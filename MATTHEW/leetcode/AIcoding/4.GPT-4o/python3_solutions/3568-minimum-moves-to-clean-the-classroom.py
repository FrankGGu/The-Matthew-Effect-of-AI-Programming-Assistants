class Solution:
    def minimumMoves(self, grid: List[List[int]]) -> int:
        n = len(grid)
        m = len(grid[0]) if n > 0 else 0
        if n == 0 or m == 0:
            return 0

        moves = 0
        for i in range(n):
            for j in range(m):
                if grid[i][j] == 1:
                    moves += 1
                    if i + 1 < n:
                        grid[i + 1][j] = 1
                    if j + 1 < m:
                        grid[i][j + 1] = 1
                    if i + 1 < n and j + 1 < m:
                        grid[i + 1][j + 1] = 1
        return moves