class Solution:
    def longestIncreasingPath(self, matrix: List[List[int]]) -> int:
        if not matrix or not matrix[0]:
            return 0

        rows, cols = len(matrix), len(matrix[0])
        dp = [[-1] * cols for _ in range(rows)]

        def dfs(r, c):
            if dp[r][c] != -1:
                return dp[r][c]
            max_length = 1
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and matrix[nr][nc] > matrix[r][c]:
                    max_length = max(max_length, 1 + dfs(nr, nc))
            dp[r][c] = max_length
            return max_length

        longest_path = 0
        for r in range(rows):
            for c in range(cols):
                longest_path = max(longest_path, dfs(r, c))

        return longest_path