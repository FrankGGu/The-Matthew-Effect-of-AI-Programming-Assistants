import collections

class Solution:
    def maxDistance(self, grid: list[list[int]]) -> int:
        m, n = len(grid), len(grid[0])

        q = collections.deque()
        land_count = 0

        for r in range(m):
            for c in range(n):
                if grid[r][c] == 1:
                    q.append((r, c))
                    land_count += 1

        if land_count == 0 or land_count == m * n:
            return -1

        max_dist = -1
        dist = -1 

        dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while q:
            dist += 1
            current_level_size = len(q)

            for _ in range(current_level_size):
                r, c = q.popleft()

                for dr, dc in dirs:
                    nr, nc = r + dr, c + dc

                    if 0 <= nr < m and 0 <= nc < n and grid[nr][nc] == 0:
                        grid[nr][nc] = 1
                        q.append((nr, nc))
                        max_dist = dist

        return max_dist