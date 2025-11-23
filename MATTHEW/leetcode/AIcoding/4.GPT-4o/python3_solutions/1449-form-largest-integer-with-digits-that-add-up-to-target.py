class Solution:
    def largestInteger(self, target: int) -> str:
        dp = [""] * (target + 1)
        dp[0] = ""

        for i in range(1, target + 1):
            for j in range(1, 10):
                if i - j >= 0 and dp[i - j] != "":
                    dp[i] = max(dp[i], str(j) + dp[i - j])

        return dp[target] if dp[target] else "0"