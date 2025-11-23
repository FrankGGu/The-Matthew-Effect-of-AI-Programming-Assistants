import heapq

class Solution:
    def maximumSafenessFactor(self, grid: List[List[int]]) -> int:
        n = len(grid)
        if grid[0][0] == 1 or grid[n-1][n-1] == 1:
            return 0

        # BFS to compute minimum distance to any thief
        q = deque()
        dist = [[-1 for _ in range(n)] for _ in range(n)]
        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    q.append((i, j))
                    dist[i][j] = 0

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        while q:
            i, j = q.popleft()
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < n and 0 <= nj < n and dist[ni][nj] == -1:
                    dist[ni][nj] = dist[i][j] + 1
                    q.append((ni, nj))

        # Dijkstra's algorithm to find the path with maximum minimum distance
        heap = [(-dist[0][0], 0, 0)]
        visited = [[False for _ in range(n)] for _ in range(n)]
        visited[0][0] = True
        res = float('inf')

        while heap:
            current_dist, i, j = heapq.heappop(heap)
            current_dist = -current_dist
            res = min(res, current_dist)
            if i == n-1 and j == n-1:
                return res
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < n and 0 <= nj < n and not visited[ni][nj]:
                    visited[ni][nj] = True
                    heapq.heappush(heap, (-dist[ni][nj], ni, nj))

        return res