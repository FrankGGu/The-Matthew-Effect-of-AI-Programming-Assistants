from collections import deque

class Solution:
    def shortestPath(self, grid: List[List[int]], k: int) -> int:
        m, n = len(grid), len(grid[0])
        if m == 1 and n == 1: return 0
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        queue = deque([(0, 0, k, 0)])  # (x, y, remaining_k, steps)
        visited = set((0, 0, k))

        while queue:
            x, y, remaining_k, steps = queue.popleft()

            for dx, dy in directions:
                nx, ny = x + dx, y + dy

                if 0 <= nx < m and 0 <= ny < n:
                    new_k = remaining_k - grid[nx][ny]
                    if nx == m - 1 and ny == n - 1:
                        return steps + 1
                    if new_k >= 0 and (nx, ny, new_k) not in visited:
                        visited.add((nx, ny, new_k))
                        queue.append((nx, ny, new_k, steps + 1))

        return -1