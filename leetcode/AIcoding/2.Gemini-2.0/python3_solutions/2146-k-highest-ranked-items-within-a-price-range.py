from typing import List
from collections import deque

class Solution:
    def highestRankedKItems(self, grid: List[List[int]], pricing: List[int], start: List[int], k: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        low, high = pricing
        sx, sy = start
        q = deque([(sx, sy, 0)])
        visited = set([(sx, sy)])
        items = []

        while q:
            x, y, dist = q.popleft()
            if low <= grid[x][y] <= high:
                items.append((dist, grid[x][y], x, y))

            for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and grid[nx][ny] != 0 and (nx, ny) not in visited:
                    q.append((nx, ny, dist + 1))
                    visited.add((nx, ny))

        items.sort()

        result = []
        for i in range(min(k, len(items))):
            result.append([items[i][2], items[i][3]])

        return result