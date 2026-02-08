import heapq

class Solution:
    def maxPoints(self, grid: list[list[int]], queries: list[int]) -> list[int]:
        m, n = len(grid), len(grid[0])
        visited = [[False] * n for _ in range(m)]
        heap = [(grid[0][0], 0, 0)]
        visited[0][0] = True
        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        query_indices = list(range(len(queries)))
        query_indices.sort(key=lambda i: queries[i])

        result = [0] * len(queries)
        points = 0

        for i in query_indices:
            query = queries[i]

            while heap and heap[0][0] < query:
                val, r, c = heapq.heappop(heap)
                points += 1

                for dr, dc in directions:
                    nr, nc = r + dr, c + dc
                    if 0 <= nr < m and 0 <= nc < n and not visited[nr][nc]:
                        heapq.heappush(heap, (grid[nr][nc], nr, nc))
                        visited[nr][nc] = True

            result[i] = points

        return result