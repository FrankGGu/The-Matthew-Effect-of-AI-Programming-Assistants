class Solution:
    def countSubIslands(self, grid1: List[List[int]], grid2: List[List[int]]) -> int:
        rows, cols = len(grid1), len(grid1[0])

        def dfs(r, c):
            if r < 0 or r >= rows or c < 0 or c >= cols or grid2[r][c] == 0:
                return
            grid2[r][c] = 0
            for dr, dc in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                dfs(r + dr, c + dc)

        count = 0
        for r in range(rows):
            for c in range(cols):
                if grid2[r][c] == 1:
                    dfs(r, c)
                    if all(grid2[i][j] <= grid1[i][j] for i in range(rows) for j in range(cols) if grid2[i][j] == 0):
                        count += 1
        return count