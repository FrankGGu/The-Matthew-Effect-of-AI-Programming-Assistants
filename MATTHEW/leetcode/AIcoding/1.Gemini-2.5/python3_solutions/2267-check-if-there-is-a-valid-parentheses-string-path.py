class Solution:
    def hasValidPath(self, grid: list[list[str]]) -> bool:
        m = len(grid)
        n = len(grid[0])

        total_path_length = m + n - 1
        if total_path_length % 2 != 0:
            return False

        if grid[0][0] == ')':
            return False
        if grid[m - 1][n - 1] == '(':
            return False

        dp = [[[False] * (total_path_length + 1) for _ in range(n)] for _ in range(m)]

        dp[0][0][1] = True

        for r in range(m):
            for c in range(n):
                for k in range(total_path_length + 1):
                    if dp[r][c][k]:
                        # Try to move right
                        if c + 1 < n:
                            next_k_right = k + (1 if grid[r][c+1] == '(' else -1)
                            remaining_len_right = (m - 1 - r) + (n - 1 - (c + 1))
                            if 0 <= next_k_right <= remaining_len_right:
                                dp[r][c+1][next_k_right] = True

                        # Try to move down
                        if r + 1 < m:
                            next_k_down = k + (1 if grid[r+1][c] == '(' else -1)
                            remaining_len_down = (m - 1 - (r + 1)) + (n - 1 - c)
                            if 0 <= next_k_down <= remaining_len_down:
                                dp[r+1][c][next_k_down] = True

        return dp[m-1][n-1][0]