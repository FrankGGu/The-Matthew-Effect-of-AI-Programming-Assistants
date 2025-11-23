class MethodChaining:
    def __init__(self, value):
        self.value = value

    def add(self, x):
        self.value += x
        return self

    def subtract(self, x):
        self.value -= x
        return self

    def multiply(self, x):
        self.value *= x
        return self

    def divide(self, x):
        self.value /= x
        return self

    def get(self):
        return self.value