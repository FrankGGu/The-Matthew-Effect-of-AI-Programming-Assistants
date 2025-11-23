class Solution:
    def uniquePathsIII(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        start_row, start_col = 0, 0
        empty_cells = 0

        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 1:
                    start_row, start_col = i, j
                if grid[i][j] == 0:
                    empty_cells += 1

        self.result = 0

        def backtrack(r, c, steps):
            if steps == empty_cells + 1:
                self.result += 1
                return

            temp = grid[r][c]
            grid[r][c] = -1

            directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and grid[nr][nc] == 0:
                    backtrack(nr, nc, steps + 1)

            grid[r][c] = temp

        backtrack(start_row, start_col, 0)
        return self.result