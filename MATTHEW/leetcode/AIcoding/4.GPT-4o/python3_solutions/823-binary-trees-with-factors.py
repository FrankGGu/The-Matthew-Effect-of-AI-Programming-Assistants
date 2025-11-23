class Solution:
    def numFactoredBinaryTrees(self, arr: List[int]) -> int:
        arr.sort()
        dp = {}
        mod = 10**9 + 7

        for i in arr:
            dp[i] = 1
            for j in arr:
                if j >= i:
                    break
                if i % j == 0 and i // j in dp:
                    dp[i] += dp[j] * dp[i // j]
                    dp[i] %= mod

        return sum(dp.values()) % mod