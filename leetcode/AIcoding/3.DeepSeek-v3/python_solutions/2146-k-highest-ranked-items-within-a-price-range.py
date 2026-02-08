from collections import deque

class Solution:
    def highestRankedKItems(self, grid: List[List[int]], pricing: List[int], start: List[int], k: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        low, high = pricing
        sr, sc = start
        queue = deque()
        queue.append((sr, sc))
        visited = [[False for _ in range(n)] for _ in range(m)]
        visited[sr][sc] = True
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        items = []

        distance = 0

        while queue:
            level_size = len(queue)
            for _ in range(level_size):
                r, c = queue.popleft()
                if low <= grid[r][c] <= high:
                    items.append((distance, grid[r][c], r, c))
                for dr, dc in directions:
                    nr, nc = r + dr, c + dc
                    if 0 <= nr < m and 0 <= nc < n and grid[nr][nc] != 0 and not visited[nr][nc]:
                        visited[nr][nc] = True
                        queue.append((nr, nc))
            distance += 1

        items.sort()
        res = []
        for item in items[:k]:
            res.append([item[2], item[3]])
        return res