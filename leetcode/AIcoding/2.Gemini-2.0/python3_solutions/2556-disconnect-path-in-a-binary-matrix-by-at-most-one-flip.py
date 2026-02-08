class Solution:
    def isPossibleToCutPath(self, grid: List[List[int]]) -> bool:
        m, n = len(grid), len(grid[0])

        def dfs(i, j):
            if i == m - 1 and j == n - 1:
                return True

            grid[i][j] = 0

            if i + 1 < m and grid[i + 1][j] == 1:
                if dfs(i + 1, j):
                    return True

            if j + 1 < n and grid[i][j + 1] == 1:
                if dfs(i, j + 1):
                    return True

            return False

        temp_grid = [row[:] for row in grid]

        if not dfs(0, 0):
            return True

        grid = [row[:] for row in temp_grid]

        grid[0][0] = 0

        return not dfs(0, 0)