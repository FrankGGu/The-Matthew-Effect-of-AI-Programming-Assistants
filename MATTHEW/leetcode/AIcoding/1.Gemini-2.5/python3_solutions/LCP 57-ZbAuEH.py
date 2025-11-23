class Solution:
    def solve(self, moles: list[list[int]]) -> int:
        moles.sort()

        n = len(moles)
        if n == 0:
            return 0

        dp = [0] * n
        max_moles_hit = 0

        for i in range(n):
            t_i, x_i = moles[i]

            if t_i >= abs(x_i):
                dp[i] = 1
            else:
                dp[i] = 0

            for j in range(i):
                t_j, x_j = moles[j]

                if dp[j] > 0 and (t_i - t_j) >= abs(x_i - x_j):
                    dp[i] = max(dp[i], dp[j] + 1)

            max_moles_hit = max(max_moles_hit, dp[i])

        return max_moles_hit