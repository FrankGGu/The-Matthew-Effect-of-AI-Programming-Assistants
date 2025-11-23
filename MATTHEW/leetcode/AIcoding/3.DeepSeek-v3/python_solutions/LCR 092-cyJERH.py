class Solution:
    def minFlipsMonoIncr(self, s: str) -> int:
        n = len(s)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i+1] = prefix[i] + (1 if s[i] == '1' else 0)

        res = float('inf')
        for i in range(n + 1):
            flips = prefix[i] + (n - i) - (prefix[n] - prefix[i])
            res = min(res, flips)
        return res