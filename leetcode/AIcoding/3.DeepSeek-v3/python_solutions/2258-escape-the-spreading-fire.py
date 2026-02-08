import heapq

class Solution:
    def maximumMinutes(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        def bfs_fire():
            fire_time = [[float('inf')] * n for _ in range(m)]
            q = []
            for i in range(m):
                for j in range(n):
                    if grid[i][j] == 1:
                        fire_time[i][j] = 0
                        q.append((i, j))
            while q:
                new_q = []
                for i, j in q:
                    for di, dj in directions:
                        ni, nj = i + di, j + dj
                        if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] != 2 and fire_time[ni][nj] == float('inf'):
                            fire_time[ni][nj] = fire_time[i][j] + 1
                            new_q.append((ni, nj))
                q = new_q
            return fire_time

        fire_time = bfs_fire()

        def can_reach(wait_time):
            q = []
            heapq.heappush(q, (wait_time, 0, 0))
            visited = [[False] * n for _ in range(m)]
            visited[0][0] = True
            while q:
                time, i, j = heapq.heappop(q)
                if i == m - 1 and j == n - 1:
                    return True
                for di, dj in directions:
                    ni, nj = i + di, j + dj
                    if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] != 2 and not visited[ni][nj]:
                        new_time = time + 1
                        if ni == m - 1 and nj == n - 1:
                            if new_time <= fire_time[ni][nj]:
                                visited[ni][nj] = True
                                heapq.heappush(q, (new_time, ni, nj))
                        else:
                            if new_time < fire_time[ni][nj]:
                                visited[ni][nj] = True
                                heapq.heappush(q, (new_time, ni, nj))
            return False

        left, right = 0, m * n
        best = -1
        while left <= right:
            mid = (left + right) // 2
            if can_reach(mid):
                best = mid
                left = mid + 1
            else:
                right = mid - 1
        return best if best != m * n else 10**9