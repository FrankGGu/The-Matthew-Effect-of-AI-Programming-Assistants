from collections import deque

class Solution:
    def shortestBridge(self, grid: list[list[int]]) -> int:
        n = len(grid)

        q = deque()

        def dfs(r, c):
            if not (0 <= r < n and 0 <= c < n and grid[r][c] == 1):
                return

            grid[r][c] = 2
            q.append((r, c))

            dfs(r + 1, c)
            dfs(r - 1, c)
            dfs(r, c + 1)
            dfs(r, c - 1)

        found_first_island = False
        for r in range(n):
            for c in range(n):
                if grid[r][c] == 1:
                    dfs(r, c)
                    found_first_island = True
                    break
            if found_first_island:
                break

        distance = 0

        while q:
            size = len(q)
            for _ in range(size):
                r, c = q.popleft()

                for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                    nr, nc = r + dr, c + dc

                    if 0 <= nr < n and 0 <= nc < n:
                        if grid[nr][nc] == 1:
                            return distance
                        if grid[nr][nc] == 0:
                            grid[nr][nc] = 2
                            q.append((nr, nc))

            distance += 1

        return -1