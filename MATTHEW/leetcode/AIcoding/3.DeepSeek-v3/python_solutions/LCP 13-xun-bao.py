from collections import deque

class Solution:
    def minimalSteps(self, maze: List[str]) -> int:
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        m, n = len(maze), len(maze[0])
        start_x = start_y = end_x = end_y = -1
        stones = []
        triggers = []
        machines = []

        for i in range(m):
            for j in range(n):
                c = maze[i][j]
                if c == 'S':
                    start_x, start_y = i, j
                elif c == 'T':
                    end_x, end_y = i, j
                elif c == 'O':
                    stones.append((i, j))
                elif c == 'M':
                    machines.append((i, j))

        triggers = machines.copy()
        if not triggers:
            return self.bfs(maze, start_x, start_y, end_x, end_y)

        triggers.insert(0, (start_x, start_y))
        k = len(triggers)
        dist = [[-1] * k for _ in range(k)]

        for i in range(k):
            trigger_x, trigger_y = triggers[i]
            d = self.bfs_all(maze, trigger_x, trigger_y)
            for j in range(k):
                x, y = triggers[j]
                dist[i][j] = d[x][y]
            for j in range(len(machines)):
                x, y = machines[j]
                if d[x][y] == -1:
                    return -1
            if i == 0 and d[end_x][end_y] == -1:
                return -1

        stone_dist = [[-1] * len(machines) for _ in range(len(machines))]
        for i in range(len(machines)):
            machine_x, machine_y = machines[i]
            d = self.bfs_all(maze, machine_x, machine_y)
            for j in range(len(machines)):
                if i == j:
                    continue
                min_d = float('inf')
                for stone_x, stone_y in stones:
                    if d[stone_x][stone_y] != -1 and dist[j + 1][i] != -1:
                        min_d = min(min_d, d[stone_x][stone_y] + dist[j + 1][i])
                if min_d != float('inf'):
                    stone_dist[i][j] = min_d

        dp = [[float('inf')] * k for _ in range(1 << k)]
        dp[1][0] = 0

        for mask in range(1 << k):
            for i in range(k):
                if not (mask & (1 << i)):
                    continue
                for j in range(k):
                    if mask & (1 << j):
                        continue
                    next_mask = mask | (1 << j)
                    if j == 0:
                        continue
                    if i == 0:
                        if j <= len(machines):
                            dp[next_mask][j] = min(dp[next_mask][j], dp[mask][i] + dist[i][j])
                    else:
                        if j <= len(machines):
                            dp[next_mask][j] = min(dp[next_mask][j], dp[mask][i] + stone_dist[i - 1][j - 1])

        full_mask = (1 << k) - 1
        res = float('inf')
        for i in range(k):
            if dp[full_mask][i] != float('inf') and dist[i][0] != -1:
                res = min(res, dp[full_mask][i] + dist[i][0])

        return res if res != float('inf') else -1

    def bfs(self, maze, x, y, target_x, target_y):
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        m, n = len(maze), len(maze[0])
        visited = [[-1] * n for _ in range(m)]
        q = deque()
        q.append((x, y))
        visited[x][y] = 0

        while q:
            i, j = q.popleft()
            if i == target_x and j == target_y:
                return visited[i][j]
            for di, dj in dirs:
                ni, nj = i + di, j + dj
                if 0 <= ni < m and 0 <= nj < n and maze[ni][nj] != '#' and visited[ni][nj] == -1:
                    visited[ni][nj] = visited[i][j] + 1
                    q.append((ni, nj))
        return -1

    def bfs_all(self, maze, x, y):
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        m, n = len(maze), len(maze[0])
        visited = [[-1] * n for _ in range(m)]
        q = deque()
        q.append((x, y))
        visited[x][y] = 0

        while q:
            i, j = q.popleft()
            for di, dj in dirs:
                ni, nj = i + di, j + dj
                if 0 <= ni < m and 0 <= nj < n and maze[ni][nj] != '#' and visited[ni][nj] == -1:
                    visited[ni][nj] = visited[i][j] + 1
                    q.append((ni, nj))
        return visited