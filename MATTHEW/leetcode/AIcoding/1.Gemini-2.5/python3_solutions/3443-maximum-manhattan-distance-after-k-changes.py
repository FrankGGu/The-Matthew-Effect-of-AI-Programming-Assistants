import math

class Solution:
    def maxManhattanDistance(self, points: List[List[int]], k: int) -> int:
        N = len(points)

        # If there's only one point, no two points exist to calculate distance.
        # So the maximum distance is 0.
        if N == 1:
            return 0

        # Transformed coordinates:
        # u = x + y
        # v = x - y
        # The Manhattan distance |x1 - x2| + |y1 - y2| is equivalent to
        # max(|(x1+y1) - (x2+y2)|, |(x1-y1) - (x2-y2)|)
        # which simplifies to max(max(u) - min(u), max(v) - min(v)) over all points.
        U = []
        V = []
        for x, y in points:
            U.append(x + y)
            V.append(x - y)

        # The coordinates x and y are in [-10^9, 10^9].
        # So, u = x+y and v = x-y can range from -2*10^9 to 2*10^9.
        MAX_ABS_COORD = 10**9
        MAX_TRANSFORMED_VAL = 2 * MAX_ABS_COORD
        MIN_TRANSFORMED_VAL = -2 * MAX_ABS_COORD

        if k >= 2:
            # If we can change 2 or more points, we can move one point to (10^9, 10^9)
            # and another to (-10^9, -10^9).
            # For (10^9, 10^9): u = 2*10^9, v = 0
            # For (-10^9, -10^9): u = -2*10^9, v = 0
            # The maximum possible range for u values would be 2*10^9 - (-2*10^9) = 4*10^9.
            # The maximum possible range for v values would be 0 - 0 = 0.
            # Thus, the maximum Manhattan distance is 4*10^9.
            return MAX_TRANSFORMED_VAL - MIN_TRANSFORMED_VAL

        if k == 0:
            # No changes allowed.
            # Calculate the maximum range for u and v coordinates among the original points.
            max_u_range = max(U) - min(U)
            max_v_range = max(V) - min(V)
            return max(max_u_range, max_v_range)

        # k == 1
        # We can change the coordinates of exactly one point.
        # To maximize the range (max_val - min_val) for either U or V:
        # We can move one point's transformed coordinate (u_i or v_i) to an extreme.
        #
        # Option 1: Move u_i to MAX_TRANSFORMED_VAL.
        #   The new maximum for U will be MAX_TRANSFORMED_VAL.
        #   The new minimum for U will be the minimum among the remaining N-1 points.
        #   To maximize the range (MAX_TRANSFORMED_VAL - new_min_U), we need to minimize new_min_U.
        #   This is achieved by changing the point that originally had the largest u-value,
        #   leaving the original minimum u-value (min(U)) untouched.
        #   So, one candidate for max_u_range is MAX_TRANSFORMED_VAL - min(U).
        #
        # Option 2: Move u_i to MIN_TRANSFORMED_VAL.
        #   The new minimum for U will be MIN_TRANSFORMED_VAL.
        #   The new maximum for U will be the maximum among the remaining N-1 points.
        #   To maximize the range (new_max_U - MIN_TRANSFORMED_VAL), we need to maximize new_max_U.
        #   This is achieved by changing the point that originally had the smallest u-value,
        #   leaving the original maximum u-value (max(U)) untouched.
        #   So, another candidate for max_u_range is max(U) - MIN_TRANSFORMED_VAL.

        max_u_range_k1 = max(MAX_TRANSFORMED_VAL - min(U), max(U) - MIN_TRANSFORMED_VAL)
        max_v_range_k1 = max(MAX_TRANSFORMED_VAL - min(V), max(V) - MIN_TRANSFORMED_VAL)

        return max(max_u_range_k1, max_v_range_k1)