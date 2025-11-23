class Solution:
    def maxProfit(self, k: int, prices: List[int]) -> int:
        n = len(prices)
        if n == 0 or k == 0:
            return 0

        if 2 * k >= n:
            res = 0
            for i in range(1, n):
                res += max(0, prices[i] - prices[i - 1])
            return res

        dp = [[[-1 for _ in range(2)] for __ in range(k + 1)] for ___ in range(n)]

        def dfs(i, transactions, holding):
            if transactions == 0 or i == n:
                return 0
            if dp[i][transactions][holding] != -1:
                return dp[i][transactions][holding]

            do_nothing = dfs(i + 1, transactions, holding)
            if holding:
                sell = prices[i] + dfs(i + 1, transactions - 1, 0)
                dp[i][transactions][holding] = max(do_nothing, sell)
            else:
                buy = -prices[i] + dfs(i + 1, transactions, 1)
                dp[i][transactions][holding] = max(do_nothing, buy)
            return dp[i][transactions][holding]

        return dfs(0, k, 0)