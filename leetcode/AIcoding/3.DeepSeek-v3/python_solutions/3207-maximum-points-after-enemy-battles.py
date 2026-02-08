class Solution:
    def maxPoints(self, grid: List[List[int]], queries: List[int]) -> List[int]:
        import heapq

        m, n = len(grid), len(grid[0])
        k = len(queries)
        res = [0] * k
        queries = sorted([(val, idx) for idx, val in enumerate(queries)], key=lambda x: x[0])

        min_heap = []
        heapq.heappush(min_heap, (grid[0][0], 0, 0))
        grid[0][0] = 0  # Mark as visited

        count = 0
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        for val, idx in queries:
            while min_heap and min_heap[0][0] < val:
                current_val, i, j = heapq.heappop(min_heap)
                count += 1
                for di, dj in directions:
                    ni, nj = i + di, j + dj
                    if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] > 0:
                        heapq.heappush(min_heap, (grid[ni][nj], ni, nj))
                        grid[ni][nj] = 0  # Mark as visited
            res[idx] = count

        return res