class Solution:
    def maxTaxiEarnings(self, n: int, rides: List[List[int]]) -> int:
        rides.sort()
        dp = [0] * (n + 1)
        j = 0
        for i in range(1, n + 1):
            dp[i] = dp[i - 1]
            while j < len(rides) and rides[j][0] == i:
                start, end, tip = rides[j]
                earning = end - start + tip
                dp[end] = max(dp[end], dp[start] + earning)
                j += 1
        return dp[n]