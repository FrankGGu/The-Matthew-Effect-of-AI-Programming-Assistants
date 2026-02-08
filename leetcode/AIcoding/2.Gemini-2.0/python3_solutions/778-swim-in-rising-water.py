import heapq

class Solution:
    def swimInWater(self, grid: List[List[int]]) -> int:
        n = len(grid)
        visited = set()
        pq = [(grid[0][0], 0, 0)]
        visited.add((0, 0))
        ans = 0

        while pq:
            elevation, row, col = heapq.heappop(pq)
            ans = max(ans, elevation)

            if row == n - 1 and col == n - 1:
                return ans

            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
            for dr, dc in directions:
                new_row, new_col = row + dr, col + dc
                if 0 <= new_row < n and 0 <= new_col < n and (new_row, new_col) not in visited:
                    heapq.heappush(pq, (grid[new_row][new_col], new_row, new_col))
                    visited.add((new_row, new_col))