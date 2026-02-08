import math

class Solution:
    def minSidewayJumps(self, obstacles: list[int]) -> int:
        n = len(obstacles) - 1

        # dp[j] will store the minimum sideway jumps to reach the current point in lane j.
        # Lanes are 1-indexed (1, 2, 3), so we use an array of size 4.
        # Initialize dp for point 0.
        # We start at point 0, lane 2, with 0 jumps.
        # Other lanes are initially unreachable at point 0.
        dp = [math.inf] * 4
        dp[2] = 0

        # Iterate from point 1 to point n
        for i in range(1, n + 1):
            current_obstacles = obstacles[i]
            next_dp = [math.inf] * 4

            # Step 1: Calculate cost to reach point i in each lane by moving straight from i-1.
            # If there's an obstacle in lane j at point i, we cannot reach it by moving straight.
            for j in range(1, 4):
                if current_obstacles != j:
                    next_dp[j] = dp[j]

            # Step 2: Consider sideway jumps at point i.
            # A sideway jump costs 1. From any lane k (if no obstacle at i) that has been reached,
            # we can jump to any other lane j (if no obstacle at i) with 1 additional jump.
            # This means we can reach any unblocked lane at point i from the best reachable lane at point i
            # with one jump.

            # Find the minimum cost to reach any lane at point i (after straight moves, before jumps at point i).
            min_cost_at_i_before_jumps = math.inf
            for j in range(1, 4):
                min_cost_at_i_before_jumps = min(min_cost_at_i_before_jumps, next_dp[j])

            # Now, update next_dp considering jumps.
            # If we can reach any lane with `min_cost_at_i_before_jumps`,
            # then we can reach any other unblocked lane at point i with `min_cost_at_i_before_jumps + 1`.
            for j in range(1, 4):
                if current_obstacles != j:
                    next_dp[j] = min(next_dp[j], min_cost_at_i_before_jumps + 1)

            # Update dp for the next iteration
            dp = next_dp

        # The minimum jumps to reach point n in any of the three lanes.
        return min(dp[1], dp[2], dp[3])