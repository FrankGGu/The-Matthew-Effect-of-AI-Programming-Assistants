import heapq

class Solution:
    def maxPoints(self, grid: list[list[int]], queries: list[int]) -> list[int]:
        m, n = len(grid), len(grid[0])

        indexed_queries = sorted([(q, i) for i, q in enumerate(queries)])

        ans = [0] * len(queries)

        visited = [[False] * n for _ in range(m)]

        min_heap = []

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        heapq.heappush(min_heap, (grid[0][0], 0, 0))
        visited[0][0] = True

        current_reachable_count = 0

        for query_value, original_index in indexed_queries:
            while min_heap and min_heap[0][0] < query_value:
                val, r, c = heapq.heappop(min_heap)

                current_reachable_count += 1

                for dr, dc in directions:
                    nr, nc = r + dr, c + dc

                    if 0 <= nr < m and 0 <= nc < n and not visited[nr][nc]:
                        visited[nr][nc] = True
                        heapq.heappush(min_heap, (grid[nr][nc], nr, nc))

            ans[original_index] = current_reachable_count

        return ans