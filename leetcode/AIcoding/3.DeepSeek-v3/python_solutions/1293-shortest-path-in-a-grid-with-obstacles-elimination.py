from collections import deque

class Solution:
    def shortestPath(self, grid: List[List[int]], k: int) -> int:
        m, n = len(grid), len(grid[0])
        if m == 1 and n == 1:
            return 0

        visited = [[[False] * (k + 1) for _ in range(n)] for __ in range(m)]
        queue = deque()
        queue.append((0, 0, k, 0))
        visited[0][0][k] = True

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        while queue:
            x, y, remaining_k, steps = queue.popleft()

            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n:
                    if grid[nx][ny] == 0 and not visited[nx][ny][remaining_k]:
                        if nx == m - 1 and ny == n - 1:
                            return steps + 1
                        visited[nx][ny][remaining_k] = True
                        queue.append((nx, ny, remaining_k, steps + 1))
                    elif grid[nx][ny] == 1 and remaining_k > 0 and not visited[nx][ny][remaining_k - 1]:
                        visited[nx][ny][remaining_k - 1] = True
                        queue.append((nx, ny, remaining_k - 1, steps + 1))

        return -1