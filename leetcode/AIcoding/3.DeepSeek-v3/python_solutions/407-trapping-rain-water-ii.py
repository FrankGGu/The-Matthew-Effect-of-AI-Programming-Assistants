import heapq

class Solution:
    def trapRainWater(self, heightMap: List[List[int]]) -> int:
        if not heightMap or not heightMap[0]:
            return 0

        m, n = len(heightMap), len(heightMap[0])
        heap = []
        visited = [[False for _ in range(n)] for _ in range(m)]

        for i in range(m):
            for j in [0, n-1]:
                heapq.heappush(heap, (heightMap[i][j], i, j))
                visited[i][j] = True

        for j in range(1, n-1):
            for i in [0, m-1]:
                heapq.heappush(heap, (heightMap[i][j], i, j))
                visited[i][j] = True

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        res = 0

        while heap:
            h, x, y = heapq.heappop(heap)
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny]:
                    res += max(0, h - heightMap[nx][ny])
                    heapq.heappush(heap, (max(h, heightMap[nx][ny]), nx, ny))
                    visited[nx][ny] = True

        return res