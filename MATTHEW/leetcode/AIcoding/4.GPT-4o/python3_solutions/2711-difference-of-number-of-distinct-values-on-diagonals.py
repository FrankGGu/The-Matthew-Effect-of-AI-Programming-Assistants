class Solution:
    def differenceOfDistinctValues(self, grid: List[List[int]]) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        result = [[0] * n for _ in range(m)]

        for i in range(m):
            for j in range(n):
                diag1 = set()
                diag2 = set()

                x, y = i, j
                while x >= 0 and y >= 0:
                    diag1.add(grid[x][y])
                    x -= 1
                    y -= 1

                x, y = i, j
                while x < m and y < n:
                    diag2.add(grid[x][y])
                    x += 1
                    y += 1

                result[i][j] = abs(len(diag1) - len(diag2))

        return result