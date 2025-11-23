import heapq

class Solution:
    def minimumEffortPath(self, heights: List[List[int]]) -> int:
        rows, cols = len(heights), len(heights[0])
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        min_heap = []
        heapq.heappush(min_heap, (0, 0, 0))
        visited = [[False for _ in range(cols)] for _ in range(rows)]
        max_effort = [[float('inf') for _ in range(cols)] for _ in range(rows)]
        max_effort[0][0] = 0

        while min_heap:
            effort, x, y = heapq.heappop(min_heap)
            if x == rows - 1 and y == cols - 1:
                return effort
            if visited[x][y]:
                continue
            visited[x][y] = True
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < rows and 0 <= ny < cols:
                    new_effort = max(effort, abs(heights[x][y] - heights[nx][ny]))
                    if new_effort < max_effort[nx][ny]:
                        max_effort[nx][ny] = new_effort
                        heapq.heappush(min_heap, (new_effort, nx, ny))
        return 0