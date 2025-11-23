class Solution:
    def specialPerm(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        dp = [[0] * n for _ in range(1 << n)]

        for i in range(n):
            dp[1 << i][i] = 1

        for mask in range(1 << n):
            for last in range(n):
                if not (mask & (1 << last)):
                    continue
                for curr in range(n):
                    if mask & (1 << curr):
                        continue
                    if nums[last] % nums[curr] == 0 or nums[curr] % nums[last] == 0:
                        dp[mask | (1 << curr)][curr] += dp[mask][last]
                        dp[mask | (1 << curr)][curr] %= MOD

        total = 0
        for i in range(n):
            total += dp[(1 << n) - 1][i]
            total %= MOD

        return total