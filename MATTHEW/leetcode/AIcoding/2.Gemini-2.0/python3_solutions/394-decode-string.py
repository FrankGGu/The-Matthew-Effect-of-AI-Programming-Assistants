class Solution:
    def decodeString(self, s: str) -> str:
        stack = []
        curr_num = 0
        curr_str = ""
        for char in s:
            if char.isdigit():
                curr_num = curr_num * 10 + int(char)
            elif char == '[':
                stack.append(curr_str)
                stack.append(curr_num)
                curr_str = ""
                curr_num = 0
            elif char == ']':
                num = stack.pop()
                prev_str = stack.pop()
                curr_str = prev_str + curr_str * num
            else:
                curr_str += char
        return curr_str