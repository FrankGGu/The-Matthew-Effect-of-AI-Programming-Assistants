class Solution:
    def maximizeTheProfit(self, n: int, offers: List[List[int]]) -> int:
        offers.sort(key=lambda x: x[1])
        dp = [0] * (n + 1)
        last = 0
        for i in range(1, n + 1):
            dp[i] = dp[i - 1]
            while last < len(offers) and offers[last][1] == i - 1:
                start, end, gold = offers[last]
                dp[i] = max(dp[i], dp[start] + gold)
                last += 1
        return dp[n]