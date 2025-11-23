class Solution:
    def calculate(self, s: str) -> int:
        num = 0
        last_op = '+'
        stack = []

        s = s + '+' # Append a dummy operator to ensure the last number and operation are processed

        for char in s:
            if char.isdigit():
                num = num * 10 + int(char)
            elif char == ' ':
                continue
            else: # char is an operator (+, -, *, /)
                if last_op == '+':
                    stack.append(num)
                elif last_op == '-':
                    stack.append(-num)
                elif last_op == '*':
                    stack[-1] = stack[-1] * num
                elif last_op == '/':
                    # Integer division truncates towards zero.
                    # Python's // truncates towards negative infinity,
                    # so int(a / b) is used for truncation towards zero.
                    stack[-1] = int(stack[-1] / num)

                last_op = char
                num = 0

        return sum(stack)