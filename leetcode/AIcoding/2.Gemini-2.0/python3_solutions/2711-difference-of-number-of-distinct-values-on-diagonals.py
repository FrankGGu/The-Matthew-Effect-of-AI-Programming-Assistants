class Solution:
    def differenceOfDistinctValues(self, grid: List[List[int]]) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        result = [[0] * n for _ in range(m)]

        for i in range(m):
            for j in range(n):
                top_left = set()
                bottom_right = set()

                row, col = i - 1, j - 1
                while row >= 0 and col >= 0:
                    top_left.add(grid[row][col])
                    row -= 1
                    col -= 1

                row, col = i + 1, j + 1
                while row < m and col < n:
                    bottom_right.add(grid[row][col])
                    row += 1
                    col += 1

                result[i][j] = abs(len(top_left) - len(bottom_right))

        return result