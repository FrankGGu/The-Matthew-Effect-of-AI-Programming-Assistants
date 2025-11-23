class Solution:
    def largestIsland(self, grid: List[List[int]]) -> int:
        n = len(grid)
        color = 1
        color_size = {}
        color_size[0] = 0

        def dfs(r, c, color):
            if r < 0 or r >= n or c < 0 or c >= n or grid[r][c] != 1:
                return 0
            grid[r][c] = color
            return 1 + dfs(r+1, c, color) + dfs(r-1, c, color) + dfs(r, c+1, color) + dfs(r, c-1, color)

        for r in range(n):
            for c in range(n):
                if grid[r][c] == 1:
                    color += 1
                    color_size[color] = dfs(r, c, color)

        max_size = max(color_size.values())

        for r in range(n):
            for c in range(n):
                if grid[r][c] == 0:
                    seen_colors = set()
                    for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                        nr, nc = r + dr, c + dc
                        if 0 <= nr < n and 0 <= nc < n:
                            seen_colors.add(grid[nr][nc])
                    current_size = 1
                    for col in seen_colors:
                        current_size += color_size[col]
                    max_size = max(max_size, current_size)

        return max_size