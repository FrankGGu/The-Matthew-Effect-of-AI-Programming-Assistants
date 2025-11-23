class Solution:
    def getMaximumGold(self, grid: List[List[int]]) -> int:
        if not grid:
            return 0

        max_gold = 0
        rows, cols = len(grid), len(grid[0])

        def backtrack(r, c, current_gold):
            nonlocal max_gold
            max_gold = max(max_gold, current_gold)
            temp = grid[r][c]
            grid[r][c] = 0

            for dr, dc in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and grid[nr][nc] > 0:
                    backtrack(nr, nc, current_gold + grid[nr][nc])

            grid[r][c] = temp

        for i in range(rows):
            for j in range(cols):
                if grid[i][j] > 0:
                    backtrack(i, j, grid[i][j])

        return max_gold