class Solution:
    def maximumSafenessFactor(self, grid: List[List[int]]) -> int:
        from collections import deque

        n = len(grid)
        if grid[0][0] == 1 or grid[n-1][n-1] == 1:
            return 0

        # Step 1: BFS to compute the minimum distance to any thief for each cell
        dist = [[-1 for _ in range(n)] for _ in range(n)]
        q = deque()

        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    q.append((i, j))
                    dist[i][j] = 0

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        while q:
            x, y = q.popleft()
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and dist[nx][ny] == -1:
                    dist[nx][ny] = dist[x][y] + 1
                    q.append((nx, ny))

        # Step 2: Binary search + BFS/DFS to find the maximum safeness factor
        left, right = 0, dist[0][0]
        res = 0

        def is_possible(k):
            if dist[0][0] < k:
                return False
            visited = [[False for _ in range(n)] for _ in range(n)]
            q = deque()
            q.append((0, 0))
            visited[0][0] = True
            while q:
                x, y = q.popleft()
                if x == n-1 and y == n-1:
                    return True
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < n and 0 <= ny < n and not visited[nx][ny] and dist[nx][ny] >= k:
                        visited[nx][ny] = True
                        q.append((nx, ny))
            return False

        while left <= right:
            mid = (left + right) // 2
            if is_possible(mid):
                res = mid
                left = mid + 1
            else:
                right = mid - 1
        return res