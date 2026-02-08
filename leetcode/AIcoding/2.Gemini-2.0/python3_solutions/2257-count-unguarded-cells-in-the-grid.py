class Solution:
    def countUnguarded(self, m: int, n: int, guards: list[list[int]], walls: list[list[int]]) -> int:
        grid = [[0] * n for _ in range(m)]

        for r, c in guards:
            grid[r][c] = 1

        for r, c in walls:
            grid[r][c] = 2

        for r, c in guards:
            # Up
            for i in range(r - 1, -1, -1):
                if grid[i][c] == 2 or grid[i][c] == 1:
                    break
                grid[i][c] = -1

            # Down
            for i in range(r + 1, m):
                if grid[i][c] == 2 or grid[i][c] == 1:
                    break
                grid[i][c] = -1

            # Left
            for j in range(c - 1, -1, -1):
                if grid[r][j] == 2 or grid[r][j] == 1:
                    break
                grid[r][j] = -1

            # Right
            for j in range(c + 1, n):
                if grid[r][j] == 2 or grid[r][j] == 1:
                    break
                grid[r][j] = -1

        count = 0
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 0:
                    count += 1

        return count