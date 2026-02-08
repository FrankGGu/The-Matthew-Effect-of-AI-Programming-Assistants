class Solution:
    def nthUglyNumber(self, n: int) -> int:
        dp = [0] * n
        dp[0] = 1

        p2 = 0
        p3 = 0
        p5 = 0

        for i in range(1, n):
            next_ugly_by2 = dp[p2] * 2
            next_ugly_by3 = dp[p3] * 3
            next_ugly_by5 = dp[p5] * 5

            dp[i] = min(next_ugly_by2, next_ugly_by3, next_ugly_by5)

            if dp[i] == next_ugly_by2:
                p2 += 1
            if dp[i] == next_ugly_by3:
                p3 += 1
            if dp[i] == next_ugly_by5:
                p5 += 1

        return dp[n-1]