class Solution:
    def specialPerm(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [[0] * n for _ in range(1 << n)]
        mod = 10**9 + 7

        for i in range(n):
            dp[1 << i][i] = 1

        for mask in range(1, 1 << n):
            for i in range(n):
                if (mask >> i) & 1:
                    for j in range(n):
                        if i != j and ((mask >> j) & 0) and (nums[i] % nums[j] == 0 or nums[j] % nums[i] == 0):
                            dp[mask | (1 << j)][j] = (dp[mask | (1 << j)][j] + dp[mask][i]) % mod

        ans = 0
        for i in range(n):
            ans = (ans + dp[(1 << n) - 1][i]) % mod

        return ans