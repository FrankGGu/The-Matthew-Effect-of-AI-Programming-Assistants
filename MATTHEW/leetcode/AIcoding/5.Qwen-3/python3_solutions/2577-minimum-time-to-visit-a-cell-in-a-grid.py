import heapq

class Solution:
    def minimumTime(self, grid: list[str]) -> int:
        m, n = len(grid), len(grid[0])
        if grid[0][1] > 1 and grid[1][0] > 1:
            return -1

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        heap = [(0, 0, 0)]
        visited = [[False] * n for _ in range(m)]

        while heap:
            time, x, y = heapq.heappop(heap)
            if x == m - 1 and y == n - 1:
                return time
            if visited[x][y]:
                continue
            visited[x][y] = True
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny]:
                    new_time = time + max(1, int(grid[nx][ny]) - time)
                    heapq.heappush(heap, (new_time, nx, ny))
        return -1