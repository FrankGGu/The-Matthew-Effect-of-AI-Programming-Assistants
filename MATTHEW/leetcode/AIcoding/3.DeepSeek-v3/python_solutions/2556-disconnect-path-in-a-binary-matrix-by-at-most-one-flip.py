class Solution:
    def isPossibleToCutPath(self, grid: List[List[int]]) -> bool:
        m, n = len(grid), len(grid[0])

        def dfs(i, j):
            if i == m - 1 and j == n - 1:
                return True
            grid[i][j] = 0
            for di, dj in [(1, 0), (0, 1)]:
                ni, nj = i + di, j + dj
                if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] == 1:
                    if dfs(ni, nj):
                        return True
            return False

        if not dfs(0, 0):
            return True
        grid[0][0] = 1
        return not dfs(0, 0)