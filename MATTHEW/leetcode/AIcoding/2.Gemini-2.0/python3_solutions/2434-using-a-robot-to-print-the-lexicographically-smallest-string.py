class Solution:
    def robotWithString(self, s: str) -> str:
        n = len(s)
        suffix_min = [0] * n
        suffix_min[n - 1] = s[n - 1]
        for i in range(n - 2, -1, -1):
            suffix_min[i] = min(s[i], suffix_min[i + 1])

        stack = []
        result = ""
        for i in range(n):
            stack.append(s[i])
            while stack and stack[-1] <= suffix_min[i]:
                result += stack.pop()

        while stack:
            result += stack.pop()

        return result