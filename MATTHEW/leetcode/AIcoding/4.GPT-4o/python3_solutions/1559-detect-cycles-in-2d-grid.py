class Solution:
    def containsCycle(self, grid: List[List[str]]) -> bool:
        rows, cols = len(grid), len(grid[0])
        visited = set()

        def dfs(r, c, pr, pc):
            if (r, c) in visited:
                return True
            visited.add((r, c))
            for dr, dc in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and grid[nr][nc] == grid[r][c]:
                    if (nr, nc) != (pr, pc) and dfs(nr, nc, r, c):
                        return True
            return False

        for r in range(rows):
            for c in range(cols):
                if (r, c) not in visited and dfs(r, c, -1, -1):
                    return True
        return False