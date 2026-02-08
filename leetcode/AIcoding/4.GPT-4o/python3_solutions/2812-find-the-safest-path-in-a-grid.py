from collections import deque

class Solution:
    def maximumSafenessFactor(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        def bfs(safeness):
            visited = [[False] * n for _ in range(m)]
            queue = deque([(0, 0)])
            visited[0][0] = True

            while queue:
                x, y = queue.popleft()
                if (x, y) == (m - 1, n - 1):
                    return True
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny] and grid[nx][ny] >= safeness:
                        visited[nx][ny] = True
                        queue.append((nx, ny))
            return False

        left, right = 0, max(max(row) for row in grid)
        while left < right:
            mid = (left + right + 1) // 2
            if bfs(mid):
                left = mid
            else:
                right = mid - 1
        return left