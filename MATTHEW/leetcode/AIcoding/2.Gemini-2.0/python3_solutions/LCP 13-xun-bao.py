from collections import deque

class Solution:
    def minimalSteps(self, maze: List[str]) -> int:
        m, n = len(maze), len(maze[0])
        starts = []
        stones = []
        for i in range(m):
            for j in range(n):
                if maze[i][j] == 'S':
                    starts.append((i, j))
                elif maze[i][j] == 'O':
                    stones.append((i, j))
        targets = []
        for i in range(m):
            for j in range(n):
                if maze[i][j] == 'T':
                    targets.append((i, j))

        if not starts or not targets:
            return -1

        points = starts + stones + targets
        n_points = len(points)
        dist = [[float('inf')] * n_points for _ in range(n_points)]

        def bfs(start_idx):
            q = deque([points[start_idx]])
            visited = {points[start_idx]}
            steps = 0

            while q:
                size = len(q)
                for _ in range(size):
                    x, y = q.popleft()
                    for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                        nx, ny = x + dx, y + dy
                        if 0 <= nx < m and 0 <= ny < n and maze[nx][ny] != '#' and (nx, ny) not in visited:
                            visited.add((nx, ny))
                            q.append((nx, ny))

                            for i in range(n_points):
                                if (nx, ny) == points[i]:
                                    dist[start_idx][i] = steps + 1
                steps += 1

        for i in range(n_points):
            bfs(i)

        n_stones = len(stones)
        if n_stones == 0:
            return dist[0][n_points - 1] if dist[0][n_points - 1] != float('inf') else -1

        dp = [[float('inf')] * (1 << n_stones) for _ in range(n_stones)]
        for i in range(n_stones):
            dp[i][1 << i] = dist[0][i + 1]

        for mask in range(1, 1 << n_stones):
            for i in range(n_stones):
                if mask & (1 << i):
                    for j in range(n_stones):
                        if not (mask & (1 << j)):
                            dp[j][mask | (1 << j)] = min(dp[j][mask | (1 << j)], dp[i][mask] + dist[i + 1][j + 1])

        ans = float('inf')
        for i in range(n_stones):
            ans = min(ans, dp[i][(1 << n_stones) - 1] + dist[i + 1][n_points - 1])

        return ans if ans != float('inf') else -1