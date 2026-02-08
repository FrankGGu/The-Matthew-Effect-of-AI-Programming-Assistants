import heapq

class Solution:
    def maxPoints(self, grid: List[List[int]], queries: List[int]) -> List[int]:
        m, n = len(grid), len(grid[0])
        k = len(queries)
        queries = [(val, idx) for idx, val in enumerate(queries)]
        queries.sort()

        res = [0] * k
        min_heap = []
        heapq.heappush(min_heap, (grid[0][0], 0, 0))
        visited = [[False for _ in range(n)] for _ in range(m)]
        visited[0][0] = True
        count = 0

        for val, idx in queries:
            while min_heap and min_heap[0][0] < val:
                current_val, i, j = heapq.heappop(min_heap)
                count += 1
                for di, dj in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                    ni, nj = i + di, j + dj
                    if 0 <= ni < m and 0 <= nj < n and not visited[ni][nj]:
                        visited[ni][nj] = True
                        heapq.heappush(min_heap, (grid[ni][nj], ni, nj))
            res[idx] = count
        return res