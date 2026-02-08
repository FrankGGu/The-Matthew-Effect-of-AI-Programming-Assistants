class Solution:
    def smallestString(self, s: str) -> str:
        stack = []
        for char in s:
            while stack and stack[-1] > char:
                stack.pop()
            stack.append(char)
        return ''.join(stack)