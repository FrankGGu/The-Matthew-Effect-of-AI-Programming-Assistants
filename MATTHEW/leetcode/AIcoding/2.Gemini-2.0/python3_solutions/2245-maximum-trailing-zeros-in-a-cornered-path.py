class Solution:
    def maxTrailingZeros(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        rows = [[0, 0] for _ in range(m)]
        cols = [[0, 0] for _ in range(n)]

        def count_factors(num):
            two_count = 0
            five_count = 0
            while num > 0 and num % 2 == 0:
                two_count += 1
                num //= 2
            while num > 0 and num % 5 == 0:
                five_count += 1
                num //= 5
            return two_count, five_count

        for i in range(m):
            for j in range(n):
                two, five = count_factors(grid[i][j])
                rows[i][0] += two
                rows[i][1] += five
                cols[j][0] += two
                cols[j][1] += five

        pref_rows = [[(0, 0) for _ in range(n + 1)] for _ in range(m)]
        pref_cols = [[(0, 0) for _ in range(m + 1)] for _ in range(n)]

        for i in range(m):
            for j in range(1, n + 1):
                two, five = count_factors(grid[i][j-1])
                pref_rows[i][j] = (pref_rows[i][j-1][0] + two, pref_rows[i][j-1][1] + five)

        for j in range(n):
            for i in range(1, m + 1):
                two, five = count_factors(grid[i-1][j])
                pref_cols[j][i] = (pref_cols[j][i-1][0] + two, pref_cols[j][i-1][1] + five)

        ans = 0
        for i in range(m):
            for j in range(n):
                two, five = count_factors(grid[i][j])

                up = pref_cols[j][i]
                down = (pref_cols[j][m][0] - pref_cols[j][i+1][0], pref_cols[j][m][1] - pref_cols[j][i+1][1])
                left = pref_rows[i][j]
                right = (pref_rows[i][n][0] - pref_rows[i][j+1][0], pref_rows[i][n][1] - pref_rows[i][j+1][1])

                ans = max(ans, min(up[0] + left[0] + two, up[1] + left[1] + five))
                ans = max(ans, min(up[0] + right[0] + two, up[1] + right[1] + five))
                ans = max(ans, min(down[0] + left[0] + two, down[1] + left[1] + five))
                ans = max(ans, min(down[0] + right[0] + two, down[1] + right[1] + five))

        return ans