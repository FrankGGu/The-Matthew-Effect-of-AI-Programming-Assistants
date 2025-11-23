import collections

class Solution:
    def equalPairs(self, grid: list[list[int]]) -> int:
        n = len(grid)
        row_counts = collections.Counter()

        for r_idx in range(n):
            row_tuple = tuple(grid[r_idx])
            row_counts[row_tuple] += 1

        pair_count = 0
        for c_idx in range(n):
            col_list = []
            for r_idx in range(n):
                col_list.append(grid[r_idx][c_idx])
            col_tuple = tuple(col_list)

            if col_tuple in row_counts:
                pair_count += row_counts[col_tuple]

        return pair_count