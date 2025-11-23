import math

class Solution:
    def maxValueSum(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        # To optimize, ensure M <= N. If not, transpose the grid.
        # This makes the M^3 * N^2 complexity more efficient by having the smaller dimension cubed.
        if m > n:
            grid = [list(row) for row in zip(*grid)]  # Transpose the grid
            m, n = n, m  # Update dimensions

        max_total_sum = -math.inf

        # Helper function to find the two largest values and their original column indices in a row,
        # excluding a specific column.
        # Returns ((max1_val, max1_idx), (max2_val, max2_idx)).
        # If fewer than two valid elements are found, corresponding values will be -math.inf and indices -1.
        def get_top_two(arr_row, exclude_col):
            max1_val = -math.inf
            max1_idx = -1
            max2_val = -math.inf
            max2_idx = -1

            for col_idx, val in enumerate(arr_row):
                if col_idx == exclude_col:
                    continue
                if val > max1_val:
                    max2_val = max1_val
                    max2_idx = max1_idx
                    max1_val = val
                    max1_idx = col_idx
                elif val > max2_val:
                    max2_val = val
                    max2_idx = col_idx
            return (max1_val, max1_idx), (max2_val, max2_idx)

        # Iterate over all combinations of 3 distinct rows (i, j, k)
        # C(m, 3) combinations, which is O(m^3)
        for i in range(m):
            for j in range(i + 1, m):
                for k in range(j + 1, m):
                    # For fixed rows i, j, k, we need to find 3 distinct columns c1, c2, c3
                    # to maximize grid[i][c1] + grid[j][c2] + grid[k][c3].

                    current_max_for_rows = -math.inf

                    # Iterate over all possible columns for the first rook (in row i)
                    # This loop runs N times, making the overall complexity O(m^3 * N * N) = O(m^3 * N^2)
                    for c1 in range(n):
                        val1 = grid[i][c1]

                        # Now we need to find max(grid[j][c2] + grid[k][c3])
                        # such that c2, c3 are distinct and not equal to c1.

                        # Get top two candidates for row j, excluding c1
                        (j_max1_val, j_max1_idx), (j_max2_val, j_max2_idx) = get_top_two(grid[j], c1)

                        # Get top two candidates for row k, excluding c1
                        (k_max1_val, k_max1_idx), (k_max2_val, k_max2_idx) = get_top_two(grid[k], c1)

                        best_pair_sum_for_c1 = -math.inf

                        # Case 1: Use the top candidates from row j and row k
                        if j_max1_idx != -1 and k_max1_idx != -1:
                            if j_max1_idx != k_max1_idx:  # If their columns do not conflict
                                best_pair_sum_for_c1 = max(best_pair_sum_for_c1, j_max1_val + k_max1_val)
                            else:  # Columns conflict (j_max1_idx == k_max1_idx)
                                # Try combinations involving the second-best candidates
                                # Option A: j_max1_val with k_max2_val
                                if k_max2_idx != -1 and j_max1_idx != k_max2_idx:
                                    best_pair_sum_for_c1 = max(best_pair_sum_for_c1, j_max1_val + k_max2_val)
                                # Option B: j_max2_val with k_max1_val
                                if j_max2_idx != -1 and j_max2_idx != k_max1_idx:
                                    best_pair_sum_for_c1 = max(best_pair_sum_for_c1, j_max2_val + k_max1_val)
                                # Option C: j_max2_val with k_max2_val (if both exist and don't conflict)
                                if j_max2_idx != -1 and k_max2_idx != -1 and j_max2_idx != k_max2_idx:
                                    best_pair_sum_for_c1 = max(best_pair_sum_for_c1, j_max2_val + k_max2_val)

                        if best_pair_sum_for_c1 != -math.inf:
                            current_max_for_rows = max(current_max_for_rows, val1 + best_pair_sum_for_c1)

                    if current_max_for_rows != -math.inf:
                        max_total_sum = max(max_total_sum, current_max_for_rows)

        return max_total_sum