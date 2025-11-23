class Solution:
    def minFallingPathSum(self, grid: List[List[int]]) -> int:
        n = len(grid)
        for i in range(1, n):
            first_min = second_min = float('inf')
            first_idx = -1
            for j in range(n):
                if grid[i-1][j] < first_min:
                    second_min = first_min
                    first_min = grid[i-1][j]
                    first_idx = j
                elif grid[i-1][j] < second_min:
                    second_min = grid[i-1][j]
            for j in range(n):
                if j != first_idx:
                    grid[i][j] += first_min
                else:
                    grid[i][j] += second_min
        return min(grid[-1])