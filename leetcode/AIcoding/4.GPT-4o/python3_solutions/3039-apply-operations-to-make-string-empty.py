class Solution:
    def canBeEmpty(self, s: str) -> bool:
        stack = []
        for char in s:
            if char == 'a':
                stack.append(char)
            elif stack and char == 'b':
                stack.pop()
        return not stack