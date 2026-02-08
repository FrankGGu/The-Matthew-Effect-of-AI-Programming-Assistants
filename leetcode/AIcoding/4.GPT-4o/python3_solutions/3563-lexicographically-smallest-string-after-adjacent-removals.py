class Solution:
    def smallestString(self, s: str) -> str:
        stack = []
        for char in s:
            while stack and stack[-1] > char and (len(stack) < 2 or stack[-1] != stack[-2]):
                stack.pop()
            stack.append(char)
        return ''.join(stack)