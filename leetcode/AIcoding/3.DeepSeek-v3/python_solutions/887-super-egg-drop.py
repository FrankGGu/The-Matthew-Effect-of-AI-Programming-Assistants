class Solution:
    def superEggDrop(self, k: int, n: int) -> int:
        dp = [[0] * (k + 1) for _ in range(n + 1)]
        m = 0
        while dp[m][k] < n:
            m += 1
            for i in range(1, k + 1):
                dp[m][i] = dp[m - 1][i - 1] + dp[m - 1][i] + 1
        return m