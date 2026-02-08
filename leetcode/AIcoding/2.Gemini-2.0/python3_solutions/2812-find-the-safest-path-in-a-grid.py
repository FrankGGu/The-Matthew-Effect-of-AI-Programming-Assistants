import heapq

class Solution:
    def maximumSafenessFactor(self, grid: List[List[int]]) -> int:
        n = len(grid)
        thieves = []
        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    thieves.append((i, j))

        safeness = [[0] * n for _ in range(n)]

        for i in range(n):
            for j in range(n):
                min_dist = float('inf')
                for thief_x, thief_y in thieves:
                    min_dist = min(min_dist, abs(i - thief_x) + abs(j - thief_y))
                safeness[i][j] = min_dist

        pq = [(-safeness[0][0], 0, 0)]
        visited = set()
        max_safeness = float('inf')

        while pq:
            safe, x, y = heapq.heappop(pq)
            safe = -safe

            if (x, y) in visited:
                continue
            visited.add((x, y))

            max_safeness = min(max_safeness, safe)

            if x == n - 1 and y == n - 1:
                return max_safeness

            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and (nx, ny) not in visited:
                    heapq.heappush(pq, (-safeness[nx][ny], nx, ny))

        return 0