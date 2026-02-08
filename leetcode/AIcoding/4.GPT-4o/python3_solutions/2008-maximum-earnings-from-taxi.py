class Solution:
    def maxTaxiEarnings(self, n: int, rides: List[List[int]]) -> int:
        dp = [0] * (n + 1)
        rides.sort(key=lambda x: x[1])

        for start, end, tip in rides:
            dp[end] = max(dp[end], dp[start] + (end - start) + tip)

        for i in range(1, n + 1):
            dp[i] = max(dp[i], dp[i - 1])

        return dp[n]