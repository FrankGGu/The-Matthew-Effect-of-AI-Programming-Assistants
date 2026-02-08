class Solution:
    def longestIncreasingPath(self, matrix: List[List[int]]) -> int:
        if not matrix or not matrix[0]:
            return 0

        rows, cols = len(matrix), len(matrix[0])
        memo = [[0] * cols for _ in range(rows)]
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def dfs(i, j):
            if memo[i][j] != 0:
                return memo[i][j]

            max_path = 1
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < rows and 0 <= nj < cols and matrix[ni][nj] > matrix[i][j]:
                    max_path = max(max_path, 1 + dfs(ni, nj))

            memo[i][j] = max_path
            return max_path

        result = 0
        for i in range(rows):
            for j in range(cols):
                result = max(result, dfs(i, j))

        return result