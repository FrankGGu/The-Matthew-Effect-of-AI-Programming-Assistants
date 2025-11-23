class Solution:
    def findNthValue(self, k: int, n: int) -> int:
        dp = [0] * (n + 1)
        dp[0] = 1
        for _ in range(k):
            new_dp = [0] * (n + 1)
            for i in range(n + 1):
                if i == 0:
                    new_dp[i] = dp[i]
                else:
                    new_dp[i] = dp[i] + new_dp[i - 1]
            dp = new_dp
        return dp[n]