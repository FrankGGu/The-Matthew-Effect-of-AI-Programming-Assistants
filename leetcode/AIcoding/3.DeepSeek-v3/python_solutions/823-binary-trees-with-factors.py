class Solution:
    def numFactoredBinaryTrees(self, arr: List[int]) -> int:
        MOD = 10**9 + 7
        arr.sort()
        dp = {}
        for num in arr:
            dp[num] = 1
            for factor in arr:
                if factor >= num:
                    break
                if num % factor == 0 and num // factor in dp:
                    dp[num] += dp[factor] * dp[num // factor]
                    dp[num] %= MOD
        return sum(dp.values()) % MOD