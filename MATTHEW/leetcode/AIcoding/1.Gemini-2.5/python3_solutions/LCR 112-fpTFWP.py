class Solution:
    def longestIncreasingPath(self, matrix: List[List[int]]) -> int:
        if not matrix or not matrix[0]:
            return 0

        m, n = len(matrix), len(matrix[0])
        memo = [[0] * n for _ in range(m)]
        max_len = 0

        def dfs(r, c):
            if memo[r][c] != 0:
                return memo[r][c]

            current_max_path = 1

            dr = [-1, 1, 0, 0]
            dc = [0, 0, -1, 1]

            for i in range(4):
                nr, nc = r + dr[i], c + dc[i]

                if 0 <= nr < m and 0 <= nc < n and matrix[nr][nc] > matrix[r][c]:
                    current_max_path = max(current_max_path, 1 + dfs(nr, nc))

            memo[r][c] = current_max_path
            return current_max_path

        for r in range(m):
            for c in range(n):
                max_len = max(max_len, dfs(r, c))

        return max_len