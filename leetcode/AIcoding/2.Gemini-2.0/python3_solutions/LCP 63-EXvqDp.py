class Solution:
    def solve(self, grid: list[list[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = {}

        def dfs(x, y, dx, dy):
            if (x, y, dx, dy) in dp:
                return dp[(x, y, dx, dy)]

            if not (0 <= x < m and 0 <= y < n):
                return 0

            if grid[x][y] == 2:
                return 1

            if grid[x][y] == 1:
                if dx == 0:
                    dx, dy = -dy, dx
                else:
                    dx, dy = -dy, dx

            dp[(x, y, dx, dy)] = dfs(x + dx, y + dy, dx, dy)
            return dp[(x, y, dx, dy)]

        ans = []
        for j in range(n):
            ans.append(dfs(0, j, 1, 0))

        return ans