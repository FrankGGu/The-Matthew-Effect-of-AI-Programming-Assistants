class Solution:
    def shiftGrid(self, grid: list[list[int]], k: int) -> list[list[int]]:
        m = len(grid)
        n = len(grid[0])
        total_elements = m * n

        shifted_grid = [[0] * n for _ in range(m)]

        for r in range(m):
            for c in range(n):
                original_flat_idx = r * n + c
                new_flat_idx = (original_flat_idx + k) % total_elements

                new_r = new_flat_idx // n
                new_c = new_flat_idx % n

                shifted_grid[new_r][new_c] = grid[r][c]

        return shifted_grid