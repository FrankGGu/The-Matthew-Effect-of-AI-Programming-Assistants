class Solution:
    def maxTrailingZeros(self, grid: List[List[int]]) -> int:
        def count_factors(x):
            count_2, count_5 = 0, 0
            while x % 2 == 0 and x > 0:
                count_2 += 1
                x //= 2
            while x % 5 == 0 and x > 0:
                count_5 += 1
                x //= 5
            return count_2, count_5

        m, n = len(grid), len(grid[0])
        dp_2 = [[0] * n for _ in range(m)]
        dp_5 = [[0] * n for _ in range(m)]

        for i in range(m):
            for j in range(n):
                count_2, count_5 = count_factors(grid[i][j])
                if i == 0 and j == 0:
                    dp_2[i][j], dp_5[i][j] = count_2, count_5
                elif i == 0:
                    dp_2[i][j] = dp_2[i][j - 1] + count_2
                    dp_5[i][j] = dp_5[i][j - 1] + count_5
                elif j == 0:
                    dp_2[i][j] = dp_2[i - 1][j] + count_2
                    dp_5[i][j] = dp_5[i - 1][j] + count_5
                else:
                    dp_2[i][j] = min(dp_2[i - 1][j], dp_2[i][j - 1]) + count_2
                    dp_5[i][j] = min(dp_5[i - 1][j], dp_5[i][j - 1]) + count_5

        max_zeros = 0
        for i in range(m):
            for j in range(n):
                max_zeros = max(max_zeros, min(dp_2[i][j], dp_5[i][j]))

        return max_zeros