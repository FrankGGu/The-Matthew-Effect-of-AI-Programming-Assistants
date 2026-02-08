class Solution:
    def fillGrid(self, n: int, m: int, k: int) -> list[list[int]]:
        grid = [[0] * m for _ in range(n)]
        if k == 0:
            return grid

        if (n * m) % 2 == 0:
            if k % 2 != 0:
                return []
            else:
                for i in range(n):
                    for j in range(m):
                        grid[i][j] = 1 if (i + j) % 2 == 0 else 0

                if sum(sum(row) for row in grid) * 2 != k:
                    return []
                else:
                    return grid
        else:
            if k > n * m:
                return []

            if k % 2 == 0:
                for i in range(n):
                    for j in range(m):
                        grid[i][j] = 1 if (i + j) % 2 == 0 else 0

                if sum(sum(row) for row in grid) * 2 != k:
                    return []
                else:
                    return grid
            else:
                for i in range(n):
                    for j in range(m):
                        grid[i][j] = 1 if (i + j) % 2 == 0 else 0

                if sum(sum(row) for row in grid) * 2 -1 > k or sum(sum(row) for row in grid) * 2 + 1 < k:
                    return []

                if sum(sum(row) for row in grid) * 2 -1 == k:
                    for i in range(n):
                        for j in range(m):
                            if grid[i][j] == 1:
                                grid[i][j] = 0
                                return grid
                else:
                    for i in range(n):
                        for j in range(m):
                            if grid[i][j] == 0:
                                grid[i][j] = 1
                                return grid