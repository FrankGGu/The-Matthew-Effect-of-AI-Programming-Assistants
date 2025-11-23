from collections import deque

class Solution:
    def highestRankedKItems(self, grid: list[list[int]], pricing: list[int], start: list[int], k: int) -> list[list[int]]:
        rows, cols = len(grid), len(grid[0])
        price_min, price_max = pricing[0], pricing[1]
        start_r, start_c = start[0], start[1]

        q = deque()
        visited = set()

        q.append((start_r, start_c, 0)) # (row, col, distance)
        visited.add((start_r, start_c))

        ranked_items = [] # Stores (distance, price, row, col)

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while q:
            r, c, dist = q.popleft()

            current_price = grid[r][c]

            if current_price != 0 and price_min <= current_price <= price_max:
                ranked_items.append((dist, current_price, r, c))

            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                if 0 <= nr < rows and 0 <= nc < cols and \
                   (nr, nc) not in visited and \
                   grid[nr][nc] != 0:

                    visited.add((nr, nc))
                    q.append((nr, nc, dist + 1))

        ranked_items.sort()

        result = []
        for i in range(min(k, len(ranked_items))):
            _, _, r, c = ranked_items[i]
            result.append([r, c])

        return result