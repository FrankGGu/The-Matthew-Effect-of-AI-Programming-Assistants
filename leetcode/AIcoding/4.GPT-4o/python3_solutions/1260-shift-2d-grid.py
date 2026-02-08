class Solution:
    def shiftGrid(self, grid: List[List[int]], k: int) -> List[List[int]]:
        if not grid:
            return grid
        m, n = len(grid), len(grid[0])
        k %= (m * n)
        flat_list = [grid[i // n][i % n] for i in range(m * n)]
        shifted_list = flat_list[-k:] + flat_list[:-k]
        return [[shifted_list[i * n + j] for j in range(n)] for i in range(m)]