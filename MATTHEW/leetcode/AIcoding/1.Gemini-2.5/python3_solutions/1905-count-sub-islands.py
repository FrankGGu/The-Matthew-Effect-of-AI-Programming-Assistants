import sys

class Solution:
    def countSubIslands(self, grid1: List[List[int]], grid2: List[List[int]]) -> int:
        sys.setrecursionlimit(250000)

        m, n = len(grid1), len(grid1[0])
        sub_island_count = 0

        def dfs(r, c):
            if not (0 <= r < m and 0 <= c < n) or grid2[r][c] == 0:
                return True 

            grid2[r][c] = 0 

            is_sub = (grid1[r][c] == 1)

            is_sub = is_sub and dfs(r + 1, c)
            is_sub = is_sub and dfs(r - 1, c)
            is_sub = is_sub and dfs(r, c + 1)
            is_sub = is_sub and dfs(r, c - 1)

            return is_sub

        for r in range(m):
            for c in range(n):
                if grid2[r][c] == 1:
                    if dfs(r, c):
                        sub_island_count += 1

        return sub_island_count