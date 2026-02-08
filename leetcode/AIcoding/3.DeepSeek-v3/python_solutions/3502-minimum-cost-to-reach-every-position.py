import heapq

class Solution:
    def minCost(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]
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
            for idx, (di, dj) in enumerate(dirs):
                ni, nj = i + di, j + dj
                if 0 <= ni < m and 0 <= nj < n and not visited[ni][nj]:
                    if idx + 1 == grid[i][j]:
                        heapq.heappush(heap, (cost, ni, nj))
                    else:
                        heapq.heappush(heap, (cost + 1, ni, nj))
        return -1