class Solution:
    def numFactoredBinaryTrees(self, arr: list[int]) -> int:
        MOD = 10**9 + 7
        arr.sort()
        n = len(arr)
        dp = {}
        for i in range(n):
            dp[arr[i]] = 1
            for j in range(i):
                if arr[i] % arr[j] == 0:
                    factor = arr[i] // arr[j]
                    if factor in dp:
                        dp[arr[i]] = (dp[arr[i]] + dp[arr[j]] * dp[factor]) % MOD
        return sum(dp.values()) % MOD