class Calculator:

    def __init__(self, value):
        self.value = value

    def add(self, num):
        self.value += num
        return self

    def subtract(self, num):
        self.value -= num
        return self

    def multiply(self, num):
        self.value *= num
        return self

    def divide(self, num):
        if num == 0:
            self.value = "Error"
        else:
            self.value /= num
        return self

    def power(self, num):
        self.value = self.value ** num
        return self

    def getResult(self):
        return self.value