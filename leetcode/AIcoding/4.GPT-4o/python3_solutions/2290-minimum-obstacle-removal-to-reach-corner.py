from collections import deque

class Solution:
    def minimumObstacles(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        min_heap = [(0, 0, 0)]  # (obstacles removed, x, y)
        visited = set()

        while min_heap:
            obstacles, x, y = heappop(min_heap)
            if (x, y) in visited:
                continue
            visited.add((x, y))
            if x == rows - 1 and y == cols - 1:
                return obstacles

            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < rows and 0 <= ny < cols:
                    heappush(min_heap, (obstacles + grid[nx][ny], nx, ny))

        return -1