class Solution:
    def knightProbability(self, n: int, k: int, row: int, column: int) -> float:
        dp = {}

        def solve(r, c, moves):
            if (r, c, moves) in dp:
                return dp[(r, c, moves)]

            if r < 0 or r >= n or c < 0 or c >= n:
                return 0.0

            if moves == 0:
                return 1.0

            prob = 0.0
            prob += solve(r - 2, c - 1, moves - 1) / 8.0
            prob += solve(r - 2, c + 1, moves - 1) / 8.0
            prob += solve(r - 1, c - 2, moves - 1) / 8.0
            prob += solve(r - 1, c + 2, moves - 1) / 8.0
            prob += solve(r + 1, c - 2, moves - 1) / 8.0
            prob += solve(r + 1, c + 2, moves - 1) / 8.0
            prob += solve(r + 2, c - 1, moves - 1) / 8.0
            prob += solve(r + 2, c + 1, moves - 1) / 8.0

            dp[(r, c, moves)] = prob
            return prob

        return solve(row, column, k)