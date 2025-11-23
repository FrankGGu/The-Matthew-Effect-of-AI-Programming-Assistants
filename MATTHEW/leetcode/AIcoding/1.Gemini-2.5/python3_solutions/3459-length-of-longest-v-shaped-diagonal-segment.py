import collections

class Solution:
    def longestVShapedDiagonalSegment(self, points: list[list[int]]) -> int:
        diag1_min_x = collections.defaultdict(lambda: float('inf'))
        diag1_max_x = collections.defaultdict(lambda: float('-inf'))
        diag2_min_x = collections.defaultdict(lambda: float('inf'))
        diag2_max_x = collections.defaultdict(lambda: float('-inf'))

        for x, y in points:
            d1 = y - x  # Diagonal with slope 1 (y = x + d1)
            d2 = y + x  # Diagonal with slope -1 (y = -x + d2)

            diag1_min_x[d1] = min(diag1_min_x[d1], x)
            diag1_max_x[d1] = max(diag1_max_x[d1], x)
            diag2_min_x[d2] = min(diag2_min_x[d2], x)
            diag2_max_x[d2] = max(diag2_max_x[d2], x)

        max_total_len = 0

        for x_j, y_j in points:
            d1_j = y_j - x_j
            d2_j = y_j + x_j

            max_dist_d1 = 0
            min_x_on_d1 = diag1_min_x[d1_j]
            max_x_on_d1 = diag1_max_x[d1_j]

            if min_x_on_d1 != x_j:
                max_dist_d1 = max(max_dist_d1, abs(min_x_on_d1 - x_j))
            if max_x_on_d1 != x_j:
                max_dist_d1 = max(max_dist_d1, abs(max_x_on_d1 - x_j))

            max_dist_d2 = 0
            min_x_on_d2 = diag2_min_x[d2_j]
            max_x_on_d2 = diag2_max_x[d2_j]

            if min_x_on_d2 != x_j:
                max_dist_d2 = max(max_dist_d2, abs(min_x_on_d2 - x_j))
            if max_x_on_d2 != x_j:
                max_dist_d2 = max(max_dist_d2, abs(max_x_on_d2 - x_j))

            if max_dist_d1 > 0 and max_dist_d2 > 0:
                max_total_len = max(max_total_len, max_dist_d1 + max_dist_d2)

        return max_total_len