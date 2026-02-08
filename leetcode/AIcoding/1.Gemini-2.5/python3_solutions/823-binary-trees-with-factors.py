class Solution:
    def numFactoredBinaryTrees(self, arr: list[int]) -> int:
        MOD = 10**9 + 7
        arr.sort()
        dp = {}

        for x in arr:
            dp[x] = 1

        for i in range(len(arr)):
            root = arr[i]
            for j in range(i):
                factor1 = arr[j]

                if factor1 * factor1 > root:
                    break

                if root % factor1 == 0:
                    factor2 = root // factor1

                    if factor2 in dp:
                        if factor1 == factor2:
                            dp[root] = (dp[root] + dp[factor1] * dp[factor2]) % MOD
                        else:
                            dp[root] = (dp[root] + 2 * dp[factor1] * dp[factor2]) % MOD

        total_trees = 0
        for count in dp.values():
            total_trees = (total_trees + count) % MOD

        return total_trees