import math

class Solution:
    def minDistance(self, houses: list[int], k: int) -> int:
        n = len(houses)
        houses.sort()

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + houses[i]

        cost = [[0] * n for _ in range(n)]
        for i in range(n):
            for j in range(i, n):
                median_idx = (i + j) // 2
                median_val = houses[median_idx]

                # Calculate sum of distances from houses[i...j] to median_val
                # Sum of (median_val - houses[p]) for p in [i, median_idx]
                sum_left = (median_idx - i + 1) * median_val - (prefix_sum[median_idx+1] - prefix_sum[i])

                # Sum of (houses[p] - median_val) for p in [median_idx+1, j]
                sum_right = (prefix_sum[j+1] - prefix_sum[median_idx+1]) - (j - median_idx) * median_val

                cost[i][j] = sum_left + sum_right

        # dp[m][i] = minimum cost to place m mailboxes among the first i houses (houses[0...i-1])
        dp = [[math.inf] * (n + 1) for _ in range(k + 1)]

        # Base case: 0 mailboxes for 0 houses has 0 cost
        dp[0][0] = 0

        # Fill dp table
        # m: current number of mailboxes
        for m in range(1, k + 1):
            # i: current number of houses considered (houses[0...i-1])
            for i in range(1, n + 1):
                # prev_i: number of houses covered by (m-1) mailboxes (houses[0...prev_i-1])
                # The m-th mailbox will cover houses from index prev_i to i-1
                for prev_i in range(i):
                    if dp[m-1][prev_i] != math.inf:
                        current_mailbox_cost = cost[prev_i][i-1]
                        dp[m][i] = min(dp[m][i], dp[m-1][prev_i] + current_mailbox_cost)

        return dp[k][n]