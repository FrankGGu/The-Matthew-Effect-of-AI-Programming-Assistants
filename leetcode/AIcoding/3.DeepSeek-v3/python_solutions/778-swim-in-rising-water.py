import heapq

class Solution:
    def swimInWater(self, grid: List[List[int]]) -> int:
        n = len(grid)
        heap = []
        heapq.heappush(heap, (grid[0][0], 0, 0))
        visited = set()
        visited.add((0, 0))
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        max_time = 0

        while heap:
            time, x, y = heapq.heappop(heap)
            max_time = max(max_time, time)
            if x == n - 1 and y == n - 1:
                return max_time
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and (nx, ny) not in visited:
                    visited.add((nx, ny))
                    heapq.heappush(heap, (grid[nx][ny], nx, ny))
        return max_time