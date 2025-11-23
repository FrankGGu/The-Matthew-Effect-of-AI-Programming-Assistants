import math

class Solution:
    def minCost(self, n: int, cuts: list[int]) -> int:
        # Add the start and end points of the stick to the cuts array
        # and sort them. These points define the boundaries of all possible stick segments.
        all_points = [0] + sorted(cuts) + [n]
        num_points = len(all_points)

        # dp[i][j] will store the minimum cost to cut the stick segment
        # from all_points[i] to all_points[j].
        # Initialize dp table with zeros.
        # dp[i][i+1] will naturally be 0, representing a stick segment with no cuts possible,
        # which has a cost of 0.
        dp = [[0] * num_points for _ in range(num_points)]

        # Iterate over the length of the stick segment (number of points - 1)
        # Length 2 means a segment like (all_points[i], all_points[i+1], all_points[i+2]),
        # which has one cut point in between.
        for length in range(2, num_points):
            # Iterate over the starting index 'i' of the segment
            for i in range(num_points - length):
                j = i + length  # 'j' is the ending index of the segment

                # The cost of cutting the current segment is its length.
                current_stick_length = all_points[j] - all_points[i]

                # Initialize min_cost for this segment to infinity
                min_cost_for_segment = float('inf')

                # Iterate over all possible cut points 'k' within the current segment (i, j)
                # 'k' represents the index of the cut point in the all_points array
                for k in range(i + 1, j):
                    # The total cost for this cut 'k' is:
                    # current_stick_length (cost of making this cut)
                    # + dp[i][k] (cost of cutting the left sub-stick)
                    # + dp[k][j] (cost of cutting the right sub-stick)
                    cost = current_stick_length + dp[i][k] + dp[k][j]
                    min_cost_for_segment = min(min_cost_for_segment, cost)

                # Store the minimum cost for the segment (i, j)
                dp[i][j] = min_cost_for_segment

        # The result is the minimum cost to cut the entire stick from all_points[0] to all_points[num_points-1]
        return dp[0][num_points - 1]