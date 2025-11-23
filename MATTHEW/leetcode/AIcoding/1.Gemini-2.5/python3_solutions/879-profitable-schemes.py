class Solution:
    def profitableSchemes(self, n: int, minProfit: int, group: list[int], profit: list[int]) -> int:
        MOD = 10**9 + 7

        # dp[p][m] will store the number of ways to achieve exactly 'p' profit
        # using exactly 'm' members.
        # 'p' can go up to minProfit. If the profit exceeds minProfit, it's capped at minProfit.
        # This means dp[minProfit][m] stores ways to achieve minProfit or more profit
        # using exactly 'm' members.
        dp = [[0] * (n + 1) for _ in range(minProfit + 1)]

        # Base case: there is one way to achieve 0 profit with 0 members (by doing nothing)
        dp[0][0] = 1

        # Iterate through each scheme
        for g, p in zip(group, profit):
            # Iterate members from n down to g (to avoid using the same scheme multiple times
            # in the current iteration's calculation, simulating a 0/1 knapsack)
            for m_idx in range(n, g - 1, -1):
                # Iterate profit from minProfit down to 0
                for p_idx in range(minProfit, -1, -1):
                    # Calculate the new profit index after adding the current scheme's profit.
                    # Cap the profit at minProfit. This ensures dp[minProfit][m] accumulates
                    # all ways to achieve minProfit or more.
                    new_profit_idx = min(p_idx + p, minProfit)

                    # Add the number of ways to achieve p_idx profit with m_idx - g members
                    # to the new state (new_profit_idx, m_idx)
                    dp[new_profit_idx][m_idx] = (dp[new_profit_idx][m_idx] + dp[p_idx][m_idx - g]) % MOD

        # The total number of profitable schemes is the sum of all ways
        # to achieve at least minProfit (which is stored in dp[minProfit][:])
        # using at most n members (which is covered by summing across all m_idx from 0 to n)
        total_schemes = 0
        for m_idx in range(n + 1):
            total_schemes = (total_schemes + dp[minProfit][m_idx]) % MOD

        return total_schemes