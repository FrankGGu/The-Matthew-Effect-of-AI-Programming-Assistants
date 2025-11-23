class Solution:
    def reverseParentheses(self, s: str) -> str:
        stack = []
        current_string_chars = []

        for char in s:
            if char == '(':
                stack.append(current_string_chars)
                current_string_chars = []
            elif char == ')':
                current_string_chars.reverse()
                prev_string_chars = stack.pop()
                current_string_chars = prev_string_chars + current_string_chars
            else:
                current_string_chars.append(char)

        return "".join(current_string_chars)