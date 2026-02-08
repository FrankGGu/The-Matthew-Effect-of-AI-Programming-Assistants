class Solution:
    def maximizeTheProfit(self, n: int, offers: List[List[int]]) -> int:
        dp = [0] * (n + 1)
        offers.sort()

        for start, end, profit in offers:
            for j in range(n, end - 1, -1):
                dp[j] = max(dp[j], dp[start] + profit)

        return max(dp)