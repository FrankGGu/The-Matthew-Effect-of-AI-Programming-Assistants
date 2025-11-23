class Solution:
    def smallestNumber(self, pattern: str) -> str:
        n = len(pattern)
        result = ""
        stack = []
        for i in range(n):
            stack.append(i + 1)
            if pattern[i] == 'I':
                while stack:
                    result += str(stack.pop())
        stack.append(n + 1)
        while stack:
            result += str(stack.pop())
        return result