from typing import List
import heapq

class Solution:
    def maximumMinutes(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])

        def bfs(starts, time):
            dist = [[float('inf')] * n for _ in range(m)]
            q = []
            for i, j in starts:
                dist[i][j] = time
                heapq.heappush(q, (time, i, j))
            while q:
                t, i, j = heapq.heappop(q)
                for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                    ni, nj = i + dx, j + dy
                    if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] == 0 and dist[ni][nj] > t + 1:
                        dist[ni][nj] = t + 1
                        heapq.heappush(q, (t + 1, ni, nj))
            return dist

        fire = []
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    fire.append((i, j))

        person_dist = bfs([(0, 0)], 0)
        fire_dist = bfs(fire, 0)

        if person_dist[m-1][n-1] == float('inf'):
            return -1

        if fire_dist[m-1][n-1] < person_dist[m-1][n-1]:
            return -1

        if fire_dist[m-1][n-1] > person_dist[m-1][n-1]:
            return 24 * 60

        def is_safe(i, j):
            return fire_dist[i][j] > person_dist[i][j] or (fire_dist[i][j] == person_dist[i][j] and (i == m-1 or j == n-1))

        left, right = 0, 24 * 60
        answer = 0
        while left <= right:
            mid = (left + right) // 2
            person_dist = bfs([(0, 0)], mid)
            if person_dist[m-1][n-1] == float('inf'):
                right = mid - 1
            else:
                valid = True
                for i in range(m):
                    for j in range(n):
                        if grid[i][j] == 0 and person_dist[i][j] != float('inf') and fire_dist[i][j] < person_dist[i][j]:
                            valid = False
                            break
                    if not valid:
                        break
                if valid:
                    answer = mid
                    left = mid + 1
                else:
                    right = mid - 1
        return answer