class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        for char in s:
            if char == 'a':
                stack.append(char)
            elif char == 'b':
                if not stack or stack[-1] != 'a':
                    return False
                stack.pop()
            elif char == 'c':
                if not stack or stack[-1] != 'b':
                    return False
                stack.pop()
            else:
                return False
        return len(stack) == 0