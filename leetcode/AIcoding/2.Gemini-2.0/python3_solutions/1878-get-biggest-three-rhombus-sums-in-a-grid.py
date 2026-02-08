class Solution:
    def getBiggestThree(self, grid: list[list[int]]) -> list[int]:
        m, n = len(grid), len(grid[0])
        sums = set()

        def get_rhombus_sum(row, col, half_len):
            if row - half_len < 0 or row + half_len >= m or col - half_len < 0 or col + half_len >= n:
                return -1

            s = grid[row - half_len][col]
            s += grid[row + half_len][col]
            s += grid[row][col - half_len]
            s += grid[row][col + half_len]

            for i in range(1, half_len):
                s += grid[row - half_len + i][col - i]
                s += grid[row - half_len + i][col + i]
                s += grid[row + half_len - i][col - i]
                s += grid[row + half_len - i][col + i]
            return s

        for r in range(m):
            for c in range(n):
                sums.add(grid[r][c])
                for half_len in range(1, min(r + 1, m - r, c + 1, n - c)):
                    rhombus_sum = get_rhombus_sum(r, c, half_len)
                    if rhombus_sum != -1:
                        sums.add(rhombus_sum)

        result = sorted(list(sums), reverse=True)[:3]
        return result