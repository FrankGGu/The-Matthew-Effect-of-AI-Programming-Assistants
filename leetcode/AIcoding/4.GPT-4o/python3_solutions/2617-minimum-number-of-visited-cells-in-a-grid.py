from collections import deque

class Solution:
    def minimumVisitedCells(self, grid):
        rows, cols = len(grid), len(grid[0])
        queue = deque([(0, 0)])
        visited = [[float('inf')] * cols for _ in range(rows)]
        visited[0][0] = 1

        directions = [(1, 0), (0, 1)]

        while queue:
            r, c = queue.popleft()
            for dr, dc in directions:
                nr, nc = r, c
                while 0 <= nr < rows and 0 <= nc < cols and (nr > r or nc > c):
                    if visited[nr][nc] > visited[r][c] + 1:
                        visited[nr][nc] = visited[r][c] + 1
                        queue.append((nr, nc))
                    if dr == 1:
                        nr += 1
                    else:
                        nc += 1

        return visited[-1][-1] if visited[-1][-1] != float('inf') else -1