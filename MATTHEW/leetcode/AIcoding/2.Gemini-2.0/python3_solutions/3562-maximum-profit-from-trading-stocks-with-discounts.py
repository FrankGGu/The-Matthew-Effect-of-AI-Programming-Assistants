class Solution:
    def maximumProfit(self, prices: list[int], discounts: list[int], k: int) -> int:
        n = len(prices)
        m = len(discounts)

        dp = {}

        def solve(i, j, trades_left):
            if i == n or trades_left == 0:
                return 0

            if (i, j, trades_left) in dp:
                return dp[(i, j, trades_left)]

            ans = solve(i + 1, j, trades_left)

            for l in range(j, m):
                discounted_price = prices[i] * (100 - discounts[l]) / 100
                ans = max(ans, discounted_price + solve(i + 1, l + 1, trades_left - 1))

            dp[(i, j, trades_left)] = ans
            return ans

        return int(solve(0, 0, k))