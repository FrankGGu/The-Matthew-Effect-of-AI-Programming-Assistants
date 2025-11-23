class Solution:
    def longestVShapedDiagonal(self, grid: List[List[int]]) -> int:
        if not grid or not grid[0]:
            return 0

        m, n = len(grid), len(grid[0])
        max_len = 0

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    # Check right-down diagonal
                    x, y = i, j
                    length = 0
                    while x < m and y < n and grid[x][y] == 1:
                        x += 1
                        y += 1
                        length += 1

                    # Check left-down diagonal
                    x, y = i, j
                    while x < m and y >= 0 and grid[x][y] == 1:
                        x += 1
                        y -= 1
                        length += 1

                    # Subtract 1 to avoid double-counting the starting cell
                    length -= 1
                    max_len = max(max_len, length)

        return max_len