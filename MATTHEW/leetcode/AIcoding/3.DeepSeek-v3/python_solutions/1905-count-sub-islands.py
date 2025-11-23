class Solution:
    def countSubIslands(self, grid1: List[List[int]], grid2: List[List[int]]) -> int:
        m, n = len(grid1), len(grid1[0])
        count = 0

        def dfs(i, j):
            if i < 0 or i >= m or j < 0 or j >= n or grid2[i][j] == 0:
                return True
            grid2[i][j] = 0
            res = True
            if grid1[i][j] == 0:
                res = False
            res = dfs(i + 1, j) and res
            res = dfs(i - 1, j) and res
            res = dfs(i, j + 1) and res
            res = dfs(i, j - 1) and res
            return res

        for i in range(m):
            for j in range(n):
                if grid2[i][j] == 1 and dfs(i, j):
                    count += 1
        return count