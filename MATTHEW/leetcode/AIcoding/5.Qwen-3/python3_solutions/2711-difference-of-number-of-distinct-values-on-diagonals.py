class Solution:
    def differenceOfDistinctValues(self, grid: List[List[int]]) -> int:
        from collections import defaultdict

        rows = len(grid)
        cols = len(grid[0])

        result = [[0] * cols for _ in range(rows)]

        for i in range(rows):
            for j in range(cols):
                left_diagonal = set()
                right_diagonal = set()

                x, y = i - 1, j - 1
                while x >= 0 and y >= 0:
                    left_diagonal.add(grid[x][y])
                    x -= 1
                    y -= 1

                x, y = i + 1, j + 1
                while x < rows and y < cols:
                    right_diagonal.add(grid[x][y])
                    x += 1
                    y += 1

                result[i][j] = abs(len(left_diagonal) - len(right_diagonal))

        return result