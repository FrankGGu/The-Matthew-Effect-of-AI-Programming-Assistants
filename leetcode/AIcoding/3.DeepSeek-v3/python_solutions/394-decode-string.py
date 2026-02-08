class Solution:
    def decodeString(self, s: str) -> str:
        stack = []
        current_num = 0
        current_str = ''

        for char in s:
            if char == '[':
                stack.append((current_str, current_num))
                current_str = ''
                current_num = 0
            elif char == ']':
                prev_str, num = stack.pop()
                current_str = prev_str + current_str * num
            elif char.isdigit():
                current_num = current_num * 10 + int(char)
            else:
                current_str += char

        return current_str