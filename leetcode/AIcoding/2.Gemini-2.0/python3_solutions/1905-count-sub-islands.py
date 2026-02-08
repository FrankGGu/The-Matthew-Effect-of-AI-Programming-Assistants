class Solution:
    def countSubIslands(self, grid1: List[List[int]], grid2: List[List[int]]) -> int:
        m, n = len(grid1), len(grid1[0])

        def dfs(i, j):
            if i < 0 or i >= m or j < 0 or j >= n or grid2[i][j] == 0:
                return True

            grid2[i][j] = 0

            up = dfs(i - 1, j)
            down = dfs(i + 1, j)
            left = dfs(i, j - 1)
            right = dfs(i, j + 1)

            return up and down and left and right

        def check_subisland(i, j):
            if i < 0 or i >= m or j < 0 or j >= n or grid2[i][j] == 0:
                return True

            if grid1[i][j] == 0:
                return False

            grid2[i][j] = 0

            up = check_subisland(i - 1, j)
            down = check_subisland(i + 1, j)
            left = check_subisland(i, j - 1)
            right = check_subisland(i, j + 1)

            return up and down and left and right

        count = 0
        for i in range(m):
            for j in range(n):
                if grid2[i][j] == 1:
                    if check_subisland(i, j):
                        count += 1
        return count