import collections

class Solution:
    def minOperations(self, grid: list[list[int]], x: int) -> int:
        flattened_grid = []
        for row in grid:
            for val in row:
                flattened_grid.append(val)

        if not flattened_grid:
            return 0

        first_remainder = flattened_grid[0] % x
        for val in flattened_grid:
            if val % x != first_remainder:
                return -1

        flattened_grid.sort()

        n = len(flattened_grid)
        median = flattened_grid[n // 2]

        operations = 0
        for val in flattened_grid:
            operations += abs(val - median) // x

        return operations