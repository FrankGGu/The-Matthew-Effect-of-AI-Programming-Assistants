class Solution:
    def colorBorder(self, grid: List[List[int]], row: int, col: int, color: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        original_color = grid[row][col]
        visited = set()

        def is_border(r, c):
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nr, nc = r + dr, c + dc
                if nr < 0 or nr >= m or nc < 0 or nc >= n or grid[nr][nc] != original_color:
                    return True
            return False

        def dfs(r, c):
            visited.add((r, c))
            if is_border(r, c):
                result[r][c] = color
            else:
                result[r][c] = original_color

            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < m and 0 <= nc < n and (nr, nc) not in visited and grid[nr][nc] == original_color:
                    dfs(nr, nc)

        result = [[0] * n for _ in range(m)]
        dfs(row, col)

        for r in range(m):
            for c in range(n):
                if result[r][c] == original_color:
                    result[r][c] = original_color
                else:
                    result[r][c] = color

        return result