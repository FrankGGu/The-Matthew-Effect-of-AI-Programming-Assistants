class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        for char in s:
            if char == 'c':
                if len(stack) < 2 or stack[-1] != 'b' or stack[-2] != 'a':
                    return False
                stack.pop()
                stack.pop()
            else:
                stack.append(char)
        return not stack