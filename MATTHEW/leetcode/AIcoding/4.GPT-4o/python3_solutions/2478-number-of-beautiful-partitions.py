class Solution:
    def beautifulPartitions(self, s: str, k: int, minLength: int) -> int:
        mod = 10**9 + 7
        n = len(s)

        if s[0] == '0' or s[-1] == '0': 
            return 0

        # dp[i][j] means the number of ways to partition the first i characters into j parts
        dp = [[0] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 1

        for i in range(1, n + 1):
            for j in range(1, k + 1):
                if i >= minLength and s[i - minLength] == '1':
                    dp[i][j] = (dp[i][j] + dp[i - minLength][j - 1]) % mod

                if i >= minLength and s[i - minLength] == '2':
                    dp[i][j] = (dp[i][j] + dp[i - minLength][j - 1]) % mod

        return dp[n][k]