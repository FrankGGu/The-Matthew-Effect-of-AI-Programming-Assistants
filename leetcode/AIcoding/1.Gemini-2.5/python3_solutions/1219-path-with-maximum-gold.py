class Solution:
    def getMaximumGold(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])
        max_total_gold = 0

        def dfs(r, c):
            if not (0 <= r < m and 0 <= c < n and grid[r][c] > 0):
                return 0

            current_gold = grid[r][c]
            grid[r][c] = 0  # Mark as visited for the current path

            max_gold_from_here = current_gold

            # Explore all 4 directions
            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                max_gold_from_here = max(max_gold_from_here, current_gold + dfs(nr, nc))

            grid[r][c] = current_gold  # Backtrack: restore original value
            return max_gold_from_here

        for r in range(m):
            for c in range(n):
                if grid[r][c] > 0:
                    max_total_gold = max(max_total_gold, dfs(r, c))

        return max_total_gold