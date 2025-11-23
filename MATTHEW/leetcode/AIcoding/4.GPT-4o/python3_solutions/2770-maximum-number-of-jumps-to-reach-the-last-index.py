class Solution:
    def maxJumps(self, jumps: List[int]) -> int:
        n = len(jumps)
        dp = [0] * n
        dp[0] = 1

        for i in range(n):
            for j in range(i + 1, min(i + jumps[i] + 1, n)):
                dp[j] = max(dp[j], dp[i] + 1)

        return dp[-1]