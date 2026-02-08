class Solution:
    def waysToReachTarget(self, target: int, types: List[List[int]]) -> int:
        MOD = 10**9 + 7
        dp = [0] * (target + 1)
        dp[0] = 1

        for count, marks in types:
            for t in range(target, -1, -1):
                for k in range(1, count + 1):
                    if t - k * marks >= 0:
                        dp[t] = (dp[t] + dp[t - k * marks]) % MOD

        return dp[target] % MOD