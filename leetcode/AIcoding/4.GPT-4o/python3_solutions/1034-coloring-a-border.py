class Solution:
    def colorBorder(self, grid: List[List[int]], row: int, col: int, color: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        originalColor = grid[row][col]
        visited = set()
        borders = set()

        def dfs(r, c):
            if (r, c) in visited:
                return
            visited.add((r, c))
            isBorder = False
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < m and 0 <= nc < n:
                    if grid[nr][nc] == originalColor:
                        dfs(nr, nc)
                    else:
                        isBorder = True
                else:
                    isBorder = True
            if isBorder:
                borders.add((r, c))

        dfs(row, col)

        for r, c in visited:
            grid[r][c] = originalColor if (r, c) not in borders else color

        return grid