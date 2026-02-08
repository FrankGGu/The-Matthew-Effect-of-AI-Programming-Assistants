class Solution:
    def shiftGrid(self, grid: List[List[int]], k: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        total = m * n
        k %= total
        if k == 0:
            return grid
        flattened = [num for row in grid for num in row]
        shifted = flattened[-k:] + flattened[:-k]
        return [shifted[i * n : (i + 1) * n] for i in range(m)]