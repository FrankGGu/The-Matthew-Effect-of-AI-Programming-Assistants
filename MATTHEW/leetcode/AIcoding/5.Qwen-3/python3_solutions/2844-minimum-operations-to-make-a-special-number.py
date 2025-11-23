class Solution:
    def minimumOperations(self, s: str) -> int:
        n = len(s)
        res = 0
        for i in range(n - 1, 0, -1):
            if s[i] != s[i - 1]:
                res += 1
                s = s[:i - 1] + s[i] + s[i - 1] + s[i + 1:]
        return res