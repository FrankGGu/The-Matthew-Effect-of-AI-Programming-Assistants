class Solution:
    def minFallingPathSum(self, grid: List[List[int]]) -> int:
        n = len(grid)
        if n == 1:
            return grid[0][0]

        for i in range(1, n):
            min1 = min2 = float('inf')
            idx1 = -1
            for j in range(n):
                if grid[i-1][j] < min1:
                    min2 = min1
                    min1 = grid[i-1][j]
                    idx1 = j
                elif grid[i-1][j] < min2:
                    min2 = grid[i-1][j]

            for j in range(n):
                if j != idx1:
                    grid[i][j] += min1
                else:
                    grid[i][j] += min2

        return min(grid[-1])