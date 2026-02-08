class Solution:
    def getMaximumGold(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        max_gold = 0

        def dfs(r, c, current_gold):
            nonlocal max_gold
            if r < 0 or c < 0 or r >= rows or c >= cols or grid[r][c] == 0:
                max_gold = max(max_gold, current_gold)
                return

            temp = grid[r][c]
            grid[r][c] = 0
            dfs(r + 1, c, current_gold + temp)
            dfs(r - 1, c, current_gold + temp)
            dfs(r, c + 1, current_gold + temp)
            dfs(r, c - 1, current_gold + temp)
            grid[r][c] = temp

        for i in range(rows):
            for j in range(cols):
                if grid[i][j] > 0:
                    dfs(i, j, 0)

        return max_gold