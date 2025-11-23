import heapq

class Solution:
    def minCost(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        heap = []
        heapq.heappush(heap, (0, 0, 0))
        visited = set()

        while heap:
            cost, i, j = heapq.heappop(heap)
            if (i, j) in visited:
                continue
            visited.add((i, j))
            if i == m - 1 and j == n - 1:
                return cost
            for idx, (di, dj) in enumerate(dirs):
                ni, nj = i + di, j + dj
                if 0 <= ni < m and 0 <= nj < n:
                    new_cost = cost + (0 if idx + 1 == grid[i][j] else 1)
                    heapq.heappush(heap, (new_cost, ni, nj))
        return -1