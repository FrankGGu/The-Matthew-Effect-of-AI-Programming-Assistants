class Solution:
    def swimInWater(self, grid: List[List[int]]) -> int:
        import heapq

        n = len(grid)
        visited = [[False] * n for _ in range(n)]
        heap = [(grid[0][0], 0, 0)]
        visited[0][0] = True
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        result = 0

        while heap:
            level, x, y = heapq.heappop(heap)
            result = max(result, level)
            if x == n - 1 and y == n - 1:
                return result
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and not visited[nx][ny]:
                    visited[nx][ny] = True
                    heapq.heappush(heap, (grid[nx][ny], nx, ny))
        return result