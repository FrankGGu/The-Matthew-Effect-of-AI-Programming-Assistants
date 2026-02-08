class Solution:
    def sumOfPower(self, nums: List[int], k: int) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        dp = [defaultdict(int) for _ in range(n + 1)]
        dp[0][0] = 1

        for num in nums:
            for i in range(n, 0, -1):
                for s in list(dp[i - 1].keys()):
                    new_s = s + num
                    if new_s <= k:
                        dp[i][new_s] = (dp[i][new_s] + dp[i - 1][s]) % MOD

        res = 0
        for l in range(1, n + 1):
            if k in dp[l]:
                res = (res + dp[l][k] * pow(2, n - l, MOD)) % MOD
        return res