class Solution:
    def calculate(self, s: str) -> int:
        result = 0
        sign = 1
        stack = []
        i = 0
        n = len(s)

        while i < n:
            char = s[i]

            if char.isdigit():
                num = 0
                while i < n and s[i].isdigit():
                    num = num * 10 + int(s[i])
                    i += 1
                result += num * sign
                i -= 1  # Adjust i because the outer loop will increment it again
            elif char == '+':
                sign = 1
            elif char == '-':
                sign = -1
            elif char == '(':
                # Push the current result and sign onto the stack
                # Reset result and sign for the new sub-expression
                stack.append((result, sign))
                result = 0
                sign = 1
            elif char == ')':
                # Pop the previous result and sign
                # Update the current result: prev_result + (current_sub_expression_result * prev_sign)
                prev_result, prev_sign = stack.pop()
                result = prev_result + result * prev_sign
            # Spaces are skipped as i increments

            i += 1

        return result