class Solution:
    def numberOfStableArrays(self, zero: int, one: int, limit: int) -> int:
        MOD = 10**9 + 7
        dp = [[[0] * 2 for _ in range(one + 1)] for __ in range(zero + 1)]
        dp[0][0][0] = 1
        dp[0][0][1] = 1

        for z in range(zero + 1):
            for o in range(one + 1):
                if z == 0 and o == 0:
                    continue
                res0 = 0
                if z > 0:
                    res0 += dp[z - 1][o][1]
                    if z > limit:
                        res0 -= dp[z - limit - 1][o][1]
                res0 %= MOD
                res1 = 0
                if o > 0:
                    res1 += dp[z][o - 1][0]
                    if o > limit:
                        res1 -= dp[z][o - limit - 1][0]
                res1 %= MOD
                dp[z][o][0] = res0
                dp[z][o][1] = res1

        return (dp[zero][one][0] + dp[zero][one][1]) % MOD