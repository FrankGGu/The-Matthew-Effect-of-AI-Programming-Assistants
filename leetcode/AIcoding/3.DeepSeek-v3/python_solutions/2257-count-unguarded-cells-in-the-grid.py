class Solution:
    def countUnguarded(self, m: int, n: int, guards: List[List[int]], walls: List[List[int]]) -> int:
        grid = [[0] * n for _ in range(m)]
        guarded = [[False] * n for _ in range(m)]

        for i, j in guards:
            grid[i][j] = 1

        for i, j in walls:
            grid[i][j] = 2

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    for di, dj in directions:
                        ni, nj = i + di, j + dj
                        while 0 <= ni < m and 0 <= nj < n and grid[ni][nj] not in (1, 2):
                            guarded[ni][nj] = True
                            ni += di
                            nj += dj

        count = 0
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 0 and not guarded[i][j]:
                    count += 1

        return count