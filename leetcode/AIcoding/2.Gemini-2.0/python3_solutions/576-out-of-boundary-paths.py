class Solution:
    def findPaths(self, m: int, n: int, maxMove: int, startRow: int, startColumn: int) -> int:
        dp = {}
        MOD = 10**9 + 7

        def solve(row, col, moves):
            if (row, col, moves) in dp:
                return dp[(row, col, moves)]
            if moves < 0:
                return 0
            if row < 0 or row >= m or col < 0 or col >= n:
                return 1

            ans = (solve(row + 1, col, moves - 1) +
                   solve(row - 1, col, moves - 1) +
                   solve(row, col + 1, moves - 1) +
                   solve(row, col - 1, moves - 1)) % MOD

            dp[(row, col, moves)] = ans
            return ans

        return solve(startRow, startColumn, maxMove)