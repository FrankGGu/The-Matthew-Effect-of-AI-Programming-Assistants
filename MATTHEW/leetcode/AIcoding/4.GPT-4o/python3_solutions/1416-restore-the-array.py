class Solution:
    def numberOfArrays(self, s: str, k: int) -> int:
        mod = 10**9 + 7
        n = len(s)
        dp = [0] * (n + 1)
        dp[0] = 1

        for i in range(1, n + 1):
            for j in range(i, 0, -1):
                num = s[i - j:i]
                if num[0] == '0' or int(num) > k:
                    break
                dp[i] = (dp[i] + dp[i - j]) % mod

        return dp[n]