from collections import deque

class Solution:
    def shortestPath(self, grid: List[List[int]], k: int) -> int:
        m, n = len(grid), len(grid[0])
        if grid[0][0] == 1 or grid[m-1][n-1] == 1:
            return -1
        visited = [[-1 for _ in range(n)] for _ in range(m)]
        q = deque()
        q.append((0, 0, k))
        visited[0][0] = k
        steps = 0
        while q:
            for _ in range(len(q)):
                x, y, rem = q.popleft()
                if x == m - 1 and y == n - 1:
                    return steps
                for dx, dy in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < m and 0 <= ny < n:
                        if grid[nx][ny] == 1:
                            if rem > 0 and visited[nx][ny] < rem - 1:
                                visited[nx][ny] = rem - 1
                                q.append((nx, ny, rem - 1))
                        else:
                            if visited[nx][ny] < rem:
                                visited[nx][ny] = rem
                                q.append((nx, ny, rem))
            steps += 1
        return -1