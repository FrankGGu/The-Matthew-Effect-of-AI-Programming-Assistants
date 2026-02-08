class Solution:
    def colorBorder(self, grid: List[List[int]], row: int, col: int, color: int) -> List[List[int]]:
        original_color = grid[row][col]
        if original_color == color:
            return grid

        m, n = len(grid), len(grid[0])
        visited = [[False for _ in range(n)] for _ in range(m)]
        borders = []

        def dfs(r, c):
            if r < 0 or r >= m or c < 0 or c >= n or grid[r][c] != original_color or visited[r][c]:
                return
            visited[r][c] = True
            is_border = False
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nr, nc = r + dr, c + dc
                if nr < 0 or nr >= m or nc < 0 or nc >= n or grid[nr][nc] != original_color:
                    is_border = True
                    break
            if is_border:
                borders.append((r, c))
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                dfs(r + dr, c + dc)

        dfs(row, col)
        for r, c in borders:
            grid[r][c] = color
        return grid