class Solution:
    def getMaxGridHappiness(self, m: int, n: int, introvertsCount: int, extrovertsCount: int) -> int:
        dp = {}

        def solve(row, col, intro, extro, prev_row):
            if row == m:
                return 0
            if (row, col, intro, extro, prev_row) in dp:
                return dp[(row, col, intro, extro, prev_row)]

            next_row = row
            next_col = col + 1
            if next_col == n:
                next_row += 1
                next_col = 0

            res = 0

            # Option 1: Empty cell
            res = max(res, solve(next_row, next_col, intro, extro, (prev_row << 1) & ((1 << n) - 1)))

            # Option 2: Introvert
            if intro > 0:
                score = 120
                if col > 0 and prev_row & 1:
                    score -= 30
                if row > 0 and (prev_row >> (n - 1)) & 1:
                    score -= 30
                res = max(res, score + solve(next_row, next_col, intro - 1, extro, ((prev_row << 1) & ((1 << n) - 1)) | 1))

            # Option 3: Extrovert
            if extro > 0:
                score = 40
                if col > 0 and prev_row & 1:
                    score += 20
                if row > 0 and (prev_row >> (n - 1)) & 1:
                    score += 20
                res = max(res, score + solve(next_row, next_col, intro, extro - 1, ((prev_row << 1) & ((1 << n) - 1)) | 0))

            dp[(row, col, intro, extro, prev_row)] = res
            return res

        return solve(0, 0, introvertsCount, extrovertsCount, 0)