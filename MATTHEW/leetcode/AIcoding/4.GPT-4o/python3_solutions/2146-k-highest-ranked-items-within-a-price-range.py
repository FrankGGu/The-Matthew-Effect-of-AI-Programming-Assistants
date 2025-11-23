class Solution:
    def highestRankedKItems(self, grid: List[List[int]], pricing: List[int], k: int) -> List[List[int]]:
        from collections import deque

        m, n = len(grid), len(grid[0])
        price_min, price_max = pricing
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        items = []

        for i in range(m):
            for j in range(n):
                if grid[i][j] > 0 and price_min <= grid[i][j] <= price_max:
                    items.append((grid[i][j], i, j))

        items.sort(key=lambda x: (-x[0], x[1], x[2]))
        return [list(item[1:]) for item in items[:k]]