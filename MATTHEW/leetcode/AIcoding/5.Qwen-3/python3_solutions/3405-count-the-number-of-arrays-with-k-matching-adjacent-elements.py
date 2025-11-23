class Solution:
    def colorTheArray(self, n: int, k: int, a: List[int]) -> int:
        MOD = 10**9 + 7
        dp = [0] * (k + 1)
        dp[0] = 1
        for i in range(1, n):
            new_dp = [0] * (k + 1)
            for j in range(1, k + 1):
                if a[i] == a[i - 1]:
                    new_dp[j] = dp[j]
                else:
                    new_dp[j] = (dp[j - 1] + dp[j]) % MOD
            dp = new_dp
        return dp[k]