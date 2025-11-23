class Solution:
    def findIntegers(self, n: int) -> int:
        s = bin(n + 1)[2:]
        k = len(s)
        dp = [1, 2] + [0] * (k - 2)
        for i in range(2, k):
            dp[i] = dp[i - 1] + dp[i - 2]

        res = 0
        for i in range(k):
            if s[i] == '0':
                continue
            res += dp[k - 1 - i]
            if i > 0 and s[i - 1] == '1':
                break
        return res