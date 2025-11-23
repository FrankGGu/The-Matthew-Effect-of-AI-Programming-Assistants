class Solution:
    def numberOfCombinations(self, num: str) -> int:
        MOD = 10**9 + 7
        n = len(num)
        if num[0] == '0':
            return 0

        # Precompute lcp array
        lcp = [[0] * (n + 1) for _ in range(n + 1)]
        for i in range(n-1, -1, -1):
            for j in range(n-1, -1, -1):
                if num[i] == num[j]:
                    lcp[i][j] = lcp[i+1][j+1] + 1

        dp = [[0] * (n + 1) for _ in range(n + 1)]
        dp[0][0] = 1

        for i in range(1, n + 1):
            for k in range(1, i + 1):
                if num[i - k] == '0':
                    dp[i][k] = 0
                    continue
                if i - k - k >= 0:
                    l = lcp[i - k][i - k - k]
                    if l >= k or num[i - k + l] >= num[i - k - k + l]:
                        dp[i][k] = (dp[i - k][k] + dp[i][k - 1]) % MOD
                    else:
                        dp[i][k] = (dp[i - k][k - 1] + dp[i][k - 1]) % MOD
                else:
                    dp[i][k] = (dp[i - k][k] + dp[i][k - 1]) % MOD

        return dp[n][n] % MOD