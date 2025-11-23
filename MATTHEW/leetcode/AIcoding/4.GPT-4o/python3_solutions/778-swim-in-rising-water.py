import heapq

class Solution:
    def swimInWater(self, grid: List[List[int]]) -> int:
        n = len(grid)
        min_heap = [(grid[0][0], 0, 0)]
        visited = set((0, 0))
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        while min_heap:
            time, x, y = heapq.heappop(min_heap)
            if x == n - 1 and y == n - 1:
                return time

            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and (nx, ny) not in visited:
                    visited.add((nx, ny))
                    heapq.heappush(min_heap, (max(time, grid[nx][ny]), nx, ny))