class Solution:
    def getMaximumGold(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        max_gold = 0

        def dfs(r, c, current_gold):
            nonlocal max_gold
            if r < 0 or r >= rows or c < 0 or c >= cols or grid[r][c] == 0:
                return
            gold = grid[r][c]
            current_gold += gold
            max_gold = max(max_gold, current_gold)
            grid[r][c] = 0  # Mark as visited
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                dfs(r + dr, c + dc, current_gold)
            grid[r][c] = gold  # Backtrack

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] != 0:
                    dfs(r, c, 0)

        return max_gold