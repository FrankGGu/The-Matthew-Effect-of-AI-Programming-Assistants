from collections import deque

class Solution:
    def minMovesToBox(self, grid):
        m, n = len(grid), len(grid[0])
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 'S':
                    start = (i, j)
                elif grid[i][j] == 'T':
                    target = (i, j)
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def is_valid(x, y):
            return 0 <= x < m and 0 <= y < n and grid[x][y] != '#'

        def bfs(start, box):
            visited = set()
            q = deque()
            q.append((start[0], start[1], 0))
            visited.add((start[0], start[1]))
            while q:
                x, y, steps = q.popleft()
                if (x, y) == box:
                    return steps
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if is_valid(nx, ny) and (nx, ny) not in visited:
                        visited.add((nx, ny))
                        q.append((nx, ny, steps + 1))
            return -1

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 'B':
                    box = (i, j)
                    break
            else:
                continue
            break

        result = float('inf')
        for dx, dy in directions:
            nx, ny = box[0] + dx, box[1] + dy
            if is_valid(nx, ny):
                moves = bfs(start, (box[0], box[1]))
                if moves != -1:
                    result = min(result, moves + bfs((nx, ny), target))
        return result