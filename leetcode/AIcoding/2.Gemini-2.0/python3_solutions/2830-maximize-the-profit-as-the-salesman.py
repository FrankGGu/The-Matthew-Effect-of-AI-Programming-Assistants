class Solution:
    def maximizeTheProfit(self, n: int, offers: List[List[int]]) -> int:
        offers.sort()
        dp = [0] * (len(offers) + 1)

        for i in range(1, len(offers) + 1):
            start, end, gold = offers[i-1]
            dp[i] = dp[i-1]

            l, r = 0, i - 1
            idx = -1
            while l <= r:
                mid = (l + r) // 2
                if offers[mid-1][1] < start:
                    idx = mid
                    l = mid + 1
                else:
                    r = mid - 1

            if idx != -1:
                dp[i] = max(dp[i], dp[idx] + gold)
            else:
                dp[i] = max(dp[i], gold)

        return dp[len(offers)]