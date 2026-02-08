import heapq

class Solution:
    def minimumObstacles(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        heap = []
        heapq.heappush(heap, (0, 0, 0))
        visited = [[False for _ in range(n)] for _ in range(m)]

        while heap:
            cost, i, j = heapq.heappop(heap)
            if i == m - 1 and j == n - 1:
                return cost
            if visited[i][j]:
                continue
            visited[i][j] = True
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < m and 0 <= nj < n and not visited[ni][nj]:
                    heapq.heappush(heap, (cost + grid[ni][nj], ni, nj))
        return -1