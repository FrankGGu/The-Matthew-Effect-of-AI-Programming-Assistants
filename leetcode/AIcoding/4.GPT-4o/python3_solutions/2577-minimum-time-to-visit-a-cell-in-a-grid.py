import heapq

class Solution:
    def minimumTime(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        pq = [(0, 0, 0)]  # (time, x, y)
        visited = set()

        while pq:
            time, x, y = heapq.heappop(pq)
            if (x, y) in visited:
                continue
            visited.add((x, y))
            if x == m - 1 and y == n - 1:
                return time
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n:
                    wait_time = (grid[nx][ny] - (time % grid[nx][ny])) % grid[nx][ny]
                    heapq.heappush(pq, (time + wait_time + 1, nx, ny))