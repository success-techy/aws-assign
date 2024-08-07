provider "aws" {
  region = "us-east-1"  # Change to your preferred AWS region
}

resource "aws_instance" "centos_vm" {
  ami           = "ami-05f2b469e504202f7"  # CentOS 8 AMI ID (update as needed)
  instance_type = "t2.micro"
  tags = {
    Name = "c8.local"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > centos_ip.txt"
  }

  connection {
    type        = "ssh"
    user        = "centos"  # Change to appropriate user for CentOS AMI
    private_key = file("~/.ssh/id_rsa")
  }
}

resource "aws_instance" "ubuntu_vm" {
  ami           = "ami-0a0e5d9c7acc336f1"  # Ubuntu 21.04 AMI ID (update as needed)
  instance_type = "t2.micro"
  tags = {
    Name = "u21.local"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ubuntu_ip.txt"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Change to appropriate user for Ubuntu AMI
    private_key = file("~/.ssh/id_rsa")
  }
}

output "centos_ip" {
  value = aws_instance.centos_vm.public_ip
}

output "ubuntu_ip" {
  value = aws_instance.ubuntu_vm.public_ip
}
