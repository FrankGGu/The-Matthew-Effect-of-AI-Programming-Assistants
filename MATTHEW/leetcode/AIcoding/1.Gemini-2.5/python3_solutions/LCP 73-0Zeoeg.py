import collections

class Solution:
    def equalPairs(self, grid: list[list[int]]) -> int:
        row_counts = collections.Counter()

        for r in grid:
            row_counts[tuple(r)] += 1

        count = 0
        for col_tuple in zip(*grid): 
            if col_tuple in row_counts:
                count += row_counts[col_tuple]

        return count