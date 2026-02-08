class Solution:
    def minOperations(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])
        operations = 0

        for j in range(n):
            for i in range(1, m):
                if grid[i][j] <= grid[i-1][j]:
                    diff = grid[i-1][j] - grid[i][j] + 1
                    grid[i][j] += diff
                    operations += diff

        return operations