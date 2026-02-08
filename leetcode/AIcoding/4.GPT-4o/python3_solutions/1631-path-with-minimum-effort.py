import heapq

class Solution:
    def minimumEffortPath(self, heights: List[List[int]]) -> int:
        rows, cols = len(heights), len(heights[0])
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        min_effort = [[float('inf')] * cols for _ in range(rows)]
        min_effort[0][0] = 0
        pq = [(0, 0, 0)]  # (effort, x, y)

        while pq:
            effort, x, y = heapq.heappop(pq)
            if (x, y) == (rows - 1, cols - 1):
                return effort
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < rows and 0 <= ny < cols:
                    new_effort = max(effort, abs(heights[nx][ny] - heights[x][y]))
                    if new_effort < min_effort[nx][ny]:
                        min_effort[nx][ny] = new_effort
                        heapq.heappush(pq, (new_effort, nx, ny))