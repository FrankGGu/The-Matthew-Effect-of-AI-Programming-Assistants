import heapq

class Solution:
    def minimumVisitedCells(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        if m == 1 and n == 1:
            return 1

        # Initialize distance array
        dist = [[float('inf')] * n for _ in range(m)]
        dist[0][0] = 1

        # Priority queues for rows and columns
        row_heaps = [[] for _ in range(m)]
        col_heaps = [[] for _ in range(n)]

        # Initialize the first cell
        heapq.heappush(row_heaps[0], (1, 0))
        heapq.heappush(col_heaps[0], (1, 0))

        for i in range(m):
            for j in range(n):
                if i == 0 and j == 0:
                    continue

                # Process row heap
                while row_heaps[i] and row_heaps[i][0][1] + grid[i][row_heaps[i][0][1]] < j:
                    heapq.heappop(row_heaps[i])
                if row_heaps[i]:
                    dist[i][j] = min(dist[i][j], row_heaps[i][0][0] + 1)

                # Process column heap
                while col_heaps[j] and col_heaps[j][0][1] + grid[col_heaps[j][0][1]][j] < i:
                    heapq.heappop(col_heaps[j])
                if col_heaps[j]:
                    dist[i][j] = min(dist[i][j], col_heaps[j][0][0] + 1)

                if dist[i][j] != float('inf'):
                    heapq.heappush(row_heaps[i], (dist[i][j], j))
                    heapq.heappush(col_heaps[j], (dist[i][j], i))

        return dist[-1][-1] if dist[-1][-1] != float('inf') else -1