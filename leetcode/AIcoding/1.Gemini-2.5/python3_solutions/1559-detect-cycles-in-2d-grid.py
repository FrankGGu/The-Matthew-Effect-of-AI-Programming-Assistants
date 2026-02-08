class Solution:
    def containsCycle(self, grid: list[list[str]]) -> bool:
        self.rows = len(grid)
        self.cols = len(grid[0])
        self.grid = grid
        self.visited = [[False] * self.cols for _ in range(self.rows)]

        for r in range(self.rows):
            for c in range(self.cols):
                if not self.visited[r][c]:
                    if self._dfs(r, c, -1, -1, self.grid[r][c]):
                        return True
        return False

    def _dfs(self, r: int, c: int, pr: int, pc: int, target_char: str) -> bool:
        self.visited[r][c] = True

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        for dr, dc in directions:
            nr, nc = r + dr, c + dc

            if 0 <= nr < self.rows and 0 <= nc < self.cols and self.grid[nr][nc] == target_char:
                if (nr, nc) == (pr, pc):
                    continue

                if self.visited[nr][nc]:
                    return True

                if self._dfs(nr, nc, r, c, target_char):
                    return True

        return False