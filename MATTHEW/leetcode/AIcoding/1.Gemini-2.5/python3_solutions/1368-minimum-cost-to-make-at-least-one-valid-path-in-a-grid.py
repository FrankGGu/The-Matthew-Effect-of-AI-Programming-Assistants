import collections
from typing import List

class Solution:
    def minCost(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])

        dist = [[float('inf')] * n for _ in range(m)]
        dist[0][0] = 0

        dq = collections.deque()
        dq.append((0, 0))

        dr = [0, 0, 1, -1]
        dc = [1, -1, 0, 0]

        dir_to_idx = {1: 0, 2: 1, 3: 2, 4: 3}

        while dq:
            r, c = dq.popleft()

            for i in range(4):
                nr, nc = r + dr[i], c + dc[i]

                if 0 <= nr < m and 0 <= nc < n:

                    move_cost = 1
                    if dir_to_idx[grid[r][c]] == i:
                        move_cost = 0

                    new_cost = dist[r][c] + move_cost

                    if new_cost < dist[nr][nc]:
                        dist[nr][nc] = new_cost
                        if move_cost == 0:
                            dq.appendleft((nr, nc))
                        else:
                            dq.append((nr, nc))

        return dist[m-1][n-1]