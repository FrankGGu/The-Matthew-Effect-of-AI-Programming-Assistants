class Solution:
    def countNegatives(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        count = 0
        r = 0
        c = n - 1

        while r < m and c >= 0:
            if grid[r][c] < 0:
                count += (m - r)
                c -= 1
            else:
                r += 1

        return count