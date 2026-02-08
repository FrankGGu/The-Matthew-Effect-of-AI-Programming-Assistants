class Solution:
    def getMaximumGold(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        max_gold = 0

        def dfs(row, col, visited, current_gold):
            nonlocal max_gold
            if row < 0 or row >= rows or col < 0 or col >= cols or (row, col) in visited or grid[row][col] == 0:
                max_gold = max(max_gold, current_gold)
                return

            gold = grid[row][col]
            visited.add((row, col))

            dfs(row + 1, col, visited, current_gold + gold)
            dfs(row - 1, col, visited, current_gold + gold)
            dfs(row, col + 1, visited, current_gold + gold)
            dfs(row, col - 1, visited, current_gold + gold)

            visited.remove((row, col))

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] != 0:
                    dfs(r, c, set(), 0)

        return max_gold