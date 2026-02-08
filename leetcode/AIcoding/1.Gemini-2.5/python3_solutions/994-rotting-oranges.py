from collections import deque

class Solution:
    def orangesRotting(self, grid: list[list[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        q = deque()
        fresh_oranges = 0

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 2:
                    q.append((r, c, 0))
                elif grid[r][c] == 1:
                    fresh_oranges += 1

        if fresh_oranges == 0:
            return 0

        max_minutes = 0
        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while q:
            r, c, minutes = q.popleft()
            max_minutes = max(max_minutes, minutes)

            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and grid[nr][nc] == 1:
                    grid[nr][nc] = 2
                    fresh_oranges -= 1
                    q.append((nr, nc, minutes + 1))

        return max_minutes if fresh_oranges == 0 else -1