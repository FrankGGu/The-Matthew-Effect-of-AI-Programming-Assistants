import heapq

class Solution:
    def minimumTime(self, grid: List[List[int]]) -> int:
        if grid[0][1] > 1 and grid[1][0] > 1:
            return -1

        m, n = len(grid), len(grid[0])
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        heap = []
        heapq.heappush(heap, (0, 0, 0))
        visited = [[False for _ in range(n)] for _ in range(m)]
        visited[0][0] = True

        while heap:
            time, x, y = heapq.heappop(heap)
            if x == m - 1 and y == n - 1:
                return time

            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny]:
                    if grid[nx][ny] <= time + 1:
                        visited[nx][ny] = True
                        heapq.heappush(heap, (time + 1, nx, ny))
                    else:
                        diff = grid[nx][ny] - time
                        if diff % 2 == 0:
                            wait = diff + 1
                        else:
                            wait = diff
                        heapq.heappush(heap, (time + wait, nx, ny))
                        visited[nx][ny] = True

        return -1