class Solution:
    def countUnguarded(self, m: int, n: int, guards: List[List[int]], walls: List[List[int]]) -> int:
        grid = [[0] * n for _ in range(m)]

        for x, y in walls:
            grid[x][y] = -1

        for x, y in guards:
            grid[x][y] = 1

        for x, y in guards:
            for dx, dy in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                nx, ny = x, y
                while 0 <= nx < m and 0 <= ny < n and grid[nx][ny] != -1:
                    if grid[nx][ny] == 0:
                        grid[nx][ny] = 2
                    nx += dx
                    ny += dy

        return sum(row.count(0) for row in grid)