class Solution:
    def numberOfStableArrays(self, m: int, k: int) -> int:
        MOD = 10**9 + 7

        from collections import defaultdict

        dp = [defaultdict(int) for _ in range(m + 1)]
        dp[0][0] = 1

        for i in range(1, m + 1):
            for j in range(i + 1):
                for cnt in dp[i - 1]:
                    if j >= cnt:
                        dp[i][j] = (dp[i][j] + dp[i - 1][cnt]) % MOD

        return dp[m][k]