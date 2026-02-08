class Solution:
    def differenceOfDistinctValues(self, grid: List[List[int]]) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        res = [[0 for _ in range(n)] for _ in range(m)]

        for i in range(m):
            for j in range(n):
                top_left = set()
                r, c = i - 1, j - 1
                while r >= 0 and c >= 0:
                    top_left.add(grid[r][c])
                    r -= 1
                    c -= 1

                bottom_right = set()
                r, c = i + 1, j + 1
                while r < m and c < n:
                    bottom_right.add(grid[r][c])
                    r += 1
                    c += 1

                res[i][j] = abs(len(top_left) - len(bottom_right))

        return res