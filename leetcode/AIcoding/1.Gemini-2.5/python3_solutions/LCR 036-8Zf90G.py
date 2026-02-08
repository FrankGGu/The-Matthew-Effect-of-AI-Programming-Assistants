import collections

class Solution:
    def evalRPN(self, tokens: list[str]) -> int:
        stack = []
        operators = {"+", "-", "*", "/"}

        for token in tokens:
            if token in operators:
                operand2 = stack.pop()
                operand1 = stack.pop()

                if token == "+":
                    stack.append(operand1 + operand2)
                elif token == "-":
                    stack.append(operand1 - operand2)
                elif token == "*":
                    stack.append(operand1 * operand2)
                elif token == "/":
                    # Integer division truncates towards zero
                    stack.append(int(operand1 / operand2))
            else:
                stack.append(int(token))

        return stack[0]