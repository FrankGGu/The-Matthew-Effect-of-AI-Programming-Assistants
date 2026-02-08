import heapq

class Solution:
    def maxScore(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        heap = []
        for i in range(m):
            for j in range(n):
                heapq.heappush(heap, (grid[i][j], i, j))

        dp = [[-float('inf')] * n for _ in range(m)]
        max_score = -float('inf')

        while heap:
            val, i, j = heapq.heappop(heap)
            current_max = 0
            for di, dj in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                ni, nj = i + di, j + dj
                if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] < val:
                    if dp[ni][nj] + val - grid[ni][nj] > current_max:
                        current_max = dp[ni][nj] + val - grid[ni][nj]
            dp[i][j] = current_max if current_max != 0 else -float('inf')
            if dp[i][j] > max_score:
                max_score = dp[i][j]

        return max_score