class Solution:
    def minFlips(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])

        def row_to_int(row):
            res = 0
            for x in row:
                res = (res << 1) | x
            return res

        rows = [row_to_int(row) for row in grid]

        def solve(mask):
            flips = 0
            new_rows = []
            for i in range(m):
                if (mask >> i) & 1:
                    flips += 1
                    new_rows.append(~rows[i] & ((1 << n) - 1))
                else:
                    new_rows.append(rows[i])

            for i in range(m // 2):
                if new_rows[i] != new_rows[m - 1 - i]:
                    return float('inf')
            return flips

        ans = float('inf')
        for mask in range(1 << m):
            ans = min(ans, solve(mask))

        return ans if ans != float('inf') else -1