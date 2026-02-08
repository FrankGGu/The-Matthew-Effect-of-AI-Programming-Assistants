class Solution:
    def maxValueSum(self, grid: List[List[int]], k: int) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[[-1 for _ in range(k + 1)] for __ in range(n)] for ___ in range(m)]

        def dfs(i, j, left):
            if left == 0:
                return 0
            if i >= m or j >= n:
                return -float('inf')
            if dp[i][j][left] != -1:
                return dp[i][j][left]

            res = -float('inf')
            # Place rook at (i, j)
            # Mark the row and column
            # Collect all unmarked cells in the row and column
            collected = grid[i][j]
            marked_row = set()
            marked_col = set()
            marked_row.add(i)
            marked_col.add(j)
            # Collect other cells in the same row
            for x in range(n):
                if x != j and x not in marked_col:
                    collected += grid[i][x]
                    marked_col.add(x)
            # Collect other cells in the same column
            for y in range(m):
                if y != i and y not in marked_row:
                    collected += grid[y][j]
                    marked_row.add(y)
            # Next positions
            for ni in range(i, m):
                for nj in range(j + 1 if ni == i else 0, n):
                    if ni not in marked_row and nj not in marked_col:
                        res = max(res, collected + dfs(ni, nj, left - 1))
            # Also consider not placing the rook here
            res = max(res, dfs(i, j + 1, left) if j + 1 < n else dfs(i + 1, 0, left))

            dp[i][j][left] = res
            return res

        return dfs(0, 0, k)