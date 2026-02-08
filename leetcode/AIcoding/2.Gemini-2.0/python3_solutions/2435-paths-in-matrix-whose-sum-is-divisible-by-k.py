class Solution:
    def numberOfPaths(self, grid: List[List[int]], k: int) -> int:
        m, n = len(grid), len(grid[0])
        dp = {}

        def solve(row, col, rem):
            if row == m or col == n:
                return 0
            if row == m - 1 and col == n - 1:
                return 1 if (rem + grid[row][col]) % k == 0 else 0

            if (row, col, rem) in dp:
                return dp[(row, col, rem)]

            new_rem = (rem + grid[row][col]) % k

            dp[(row, col, rem)] = (solve(row + 1, col, new_rem) + solve(row, col + 1, new_rem)) % (10**9 + 7)
            return dp[(row, col, rem)]

        return solve(0, 0, 0)