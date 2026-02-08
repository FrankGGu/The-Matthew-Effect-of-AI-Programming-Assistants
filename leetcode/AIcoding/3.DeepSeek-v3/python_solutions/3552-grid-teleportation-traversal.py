import heapq

class Solution:
    def minimumVisitedCells(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        if m == 1 and n == 1:
            return 1

        # Priority queues for rows and columns
        row_heaps = [[] for _ in range(m)]
        col_heaps = [[] for _ in range(n)]

        # Initialize the distance for the starting cell
        distance = [[float('inf')] * n for _ in range(m)]
        distance[0][0] = 1

        for i in range(m):
            for j in range(n):
                # Process the row heap
                while row_heaps[i] and row_heaps[i][0][1] + grid[i][row_heaps[i][0][1]] < j:
                    heapq.heappop(row_heaps[i])
                if row_heaps[i]:
                    dist = row_heaps[i][0][0]
                    if distance[i][j] > dist + 1:
                        distance[i][j] = dist + 1

                # Process the column heap
                while col_heaps[j] and col_heaps[j][0][1] + grid[col_heaps[j][0][1]][j] < i:
                    heapq.heappop(col_heaps[j])
                if col_heaps[j]:
                    dist = col_heaps[j][0][0]
                    if distance[i][j] > dist + 1:
                        distance[i][j] = dist + 1

                if distance[i][j] != float('inf'):
                    heapq.heappush(row_heaps[i], (distance[i][j], j))
                    heapq.heappush(col_heaps[j], (distance[i][j], i))

        return distance[-1][-1] if distance[-1][-1] != float('inf') else -1