class Calculator:

    def __init__(self, initial_value: int = 0):
        self.result = initial_value

    def add(self, value: int) -> "Calculator":
        self.result += value
        return self

    def subtract(self, value: int) -> "Calculator":
        self.result -= value
        return self

    def multiply(self, value: int) -> "Calculator":
        self.result *= value
        return self

    def divide(self, value: int) -> "Calculator":
        if value == 0:
            raise ValueError("Cannot divide by zero")
        self.result /= value
        return self

    def get_result(self) -> float:
        return self.result