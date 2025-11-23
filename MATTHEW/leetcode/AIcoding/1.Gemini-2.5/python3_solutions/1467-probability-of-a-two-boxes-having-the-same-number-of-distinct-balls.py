import math
from functools import lru_cache

class Solution:
    def getProbability(self, balls: list[int]) -> float:
        k = len(balls)
        N = sum(balls)
        N_half = N // 2

        # Precompute combinations C(n, r)
        # Max n is N (sum of all balls, up to 48)
        # Max r is max(balls[i]) (up to 6) or N_half (up to 24)
        MAX_N_COMB = N
        combinations = [[0] * (MAX_N_COMB + 1) for _ in range(MAX_N_COMB + 1)]
        for i in range(MAX_N_COMB + 1):
            combinations[i][0] = 1
            for j in range(1, i + 1):
                combinations[i][j] = combinations[i-1][j-1] + combinations[i-1][j]

        @lru_cache(None)
        def find_favorable_ways(color_idx, current_balls_box1, current_balls_box2, distinct_box1, distinct_box2):
            # Base case: all colors processed
            if color_idx == k:
                # Check if both boxes have N/2 balls and same number of distinct colors
                if current_balls_box1 == N_half and current_balls_box2 == N_half and distinct_box1 == distinct_box2:
                    return 1
                return 0

            # Pruning: if current balls already exceed N/2 for either box
            if current_balls_box1 > N_half or current_balls_box2 > N_half:
                return 0

            total_ways_for_this_path = 0
            num_balls_current_color = balls[color_idx]

            # Iterate through all possible distributions of current color balls
            # i: number of balls of current color for box 1
            # j: number of balls of current color for box 2
            for i in range(num_balls_current_color + 1):
                j = num_balls_current_color - i

                # Calculate combinations for this distribution of the current color
                ways_to_distribute_current_color = combinations[num_balls_current_color][i]

                # Update distinct counts for the next recursive call
                new_distinct_box1 = distinct_box1 + (1 if i > 0 else 0)
                new_distinct_box2 = distinct_box2 + (1 if j > 0 else 0)

                # Recursive call for the next color
                total_ways_for_this_path += ways_to_distribute_current_color * \
                                            find_favorable_ways(color_idx + 1,
                                                                current_balls_box1 + i,
                                                                current_balls_box2 + j,
                                                                new_distinct_box1,
                                                                new_distinct_box2)
            return total_ways_for_this_path

        @lru_cache(None)
        def find_total_ways(color_idx, current_balls_box1, current_balls_box2):
            # Base case: all colors processed
            if color_idx == k:
                # Check if both boxes have N/2 balls
                if current_balls_box1 == N_half and current_balls_box2 == N_half:
                    return 1
                return 0

            # Pruning: if current balls already exceed N/2 for either box
            if current_balls_box1 > N_half or current_balls_box2 > N_half:
                return 0

            total_ways_for_this_path = 0
            num_balls_current_color = balls[color_idx]

            # Iterate through all possible distributions of current color balls
            for i in range(num_balls_current_color + 1):
                j = num_balls_current_color - i

                # Calculate combinations for this distribution of the current color
                ways_to_distribute_current_color = combinations[num_balls_current_color][i]

                # Recursive call for the next color
                total_ways_for_this_path += ways_to_distribute_current_color * \
                                            find_total_ways(color_idx + 1,
                                                            current_balls_box1 + i,
                                                            current_balls_box2 + j)
            return total_ways_for_this_path

        favorable_ways = find_favorable_ways(0, 0, 0, 0, 0)
        total_possible_ways = find_total_ways(0, 0, 0)

        return float(favorable_ways) / total_possible_ways