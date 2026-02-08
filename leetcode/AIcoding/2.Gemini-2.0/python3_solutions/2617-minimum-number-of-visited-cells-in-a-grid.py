from heapq import heappush, heappop

class Solution:
    def minimumVisitedCells(self, grid: list[list[int]]) -> int:
        m, n = len(grid), len(grid[0])
        pq = [(1, 0, 0)]
        visited = set()
        row_reachable = [n] * m
        col_reachable = [m] * n

        while pq:
            dist, r, c = heappop(pq)

            if (r, c) == (m - 1, n - 1):
                return dist

            if (r, c) in visited:
                continue
            visited.add((r, c))

            reach = grid[r][c]

            # Row traversal
            for nc in range(c + 1, min(c + reach + 1, row_reachable[r])):
                heappush(pq, (dist + 1, r, nc))
            row_reachable[r] = min(row_reachable[r], c + reach + 1)

            # Col traversal
            for nr in range(r + 1, min(r + reach + 1, col_reachable[c])):
                heappush(pq, (dist + 1, nr, c))
            col_reachable[c] = min(col_reachable[c], r + reach + 1)

        return -1