import math

class Solution:
    def evalRPN(self, tokens: list[str]) -> int:
        stack = []
        operators = {"+", "-", "*", "/"}

        for token in tokens:
            if token not in operators:
                stack.append(int(token))
            else:
                operand2 = stack.pop()
                operand1 = stack.pop()

                if token == "+":
                    stack.append(operand1 + operand2)
                elif token == "-":
                    stack.append(operand1 - operand2)
                elif token == "*":
                    stack.append(operand1 * operand2)
                elif token == "/":
                    # Python's default integer division (//) truncates towards negative infinity.
                    # The problem requires truncation towards zero.
                    # int() on the result of float division achieves this.
                    stack.append(int(operand1 / operand2))

        return stack[0]