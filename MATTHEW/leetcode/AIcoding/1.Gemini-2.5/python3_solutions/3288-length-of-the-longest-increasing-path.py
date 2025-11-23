class Solution:
    def longestIncreasingPath(self, matrix: list[list[int]]) -> int:
        if not matrix or not matrix[0]:
            return 0

        rows, cols = len(matrix), len(matrix[0])
        dp = [[0] * cols for _ in range(rows)]
        max_path = 0

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        def dfs(r, c):
            if dp[r][c] != 0:
                return dp[r][c]

            current_max_len = 1

            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                if 0 <= nr < rows and 0 <= nc < cols and matrix[nr][nc] > matrix[r][c]:
                    current_max_len = max(current_max_len, 1 + dfs(nr, nc))

            dp[r][c] = current_max_len
            return current_max_len

        for r in range(rows):
            for c in range(cols):
                max_path = max(max_path, dfs(r, c))

        return max_path