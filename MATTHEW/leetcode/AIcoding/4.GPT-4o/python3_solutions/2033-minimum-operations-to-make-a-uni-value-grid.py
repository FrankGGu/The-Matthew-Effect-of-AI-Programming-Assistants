class Solution:
    def minOperations(self, grid: List[List[int]], x: int) -> int:
        flat_grid = [num for row in grid for num in row]
        if any((num - flat_grid[0]) % x != 0 for num in flat_grid):
            return -1
        target = sorted(flat_grid)[len(flat_grid) // 2]
        return sum(abs(num - target) // x for num in flat_grid)