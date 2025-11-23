class Solution:
    def paintWalls(self, cost: list[int], time: list[int]) -> int:
        n = len(cost)

        # dp[j] will store the minimum cost to paint 'j' walls in total.
        # 'j' represents the sum of (1 + time[i]) for the walls we choose to paint ourselves.
        # The maximum possible value for 'j' is if we paint all 'n' walls ourselves,
        # in which case j = sum(1 + time[i] for all i) = n + sum(time).
        # max_total_walls = n + sum(time)
        # Given constraints: n <= 500, time[i] <= 500.
        # So, n + sum(time) <= 500 + 500 * 500 = 500 + 250000 = 250500.
        # We need a dp array of this size.

        # Calculate the maximum possible sum of (1 + time[i]) to determine dp array size.
        # This is a safe upper bound for the 'j' index.
        max_possible_j = n + sum(time) 

        dp = [float('inf')] * (max_possible_j + 1)

        # Base case: 0 walls painted costs 0.
        dp[0] = 0

        # Iterate through each wall
        for i in range(n):
            current_cost = cost[i]
            current_time = time[i]

            # If we paint wall 'i' ourselves, it costs current_cost.
            # It also contributes 1 wall (painted by us) + current_time walls (painted by paid painter for free).
            # So, it effectively paints (1 + current_time) walls.
            effective_walls_painted = 1 + current_time

            # This is a 0/1 knapsack type problem.
            # Iterate 'j' downwards to ensure each wall is considered only once.
            # 'j' goes from max_possible_j down to effective_walls_painted.
            for j in range(max_possible_j, effective_walls_painted - 1, -1):
                # We can choose to paint wall 'i'.
                # The new cost for 'j' walls is the cost for 'j - effective_walls_painted' walls
                # plus the cost of painting wall 'i'.
                dp[j] = min(dp[j], dp[j - effective_walls_painted] + current_cost)

        # After processing all walls, find the minimum cost to paint at least 'n' walls.
        # We iterate from 'n' up to max_possible_j to find the minimum cost.
        min_total_cost = float('inf')
        for j in range(n, max_possible_j + 1):
            min_total_cost = min(min_total_cost, dp[j])

        return min_total_cost