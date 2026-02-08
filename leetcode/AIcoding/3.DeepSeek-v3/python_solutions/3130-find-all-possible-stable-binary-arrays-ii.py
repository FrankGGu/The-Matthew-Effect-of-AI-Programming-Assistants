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
                for k in range(2):
                    res = 0
                    if k == 0:
                        for l in range(1, min(z, limit) + 1):
                            if z - l >= 0:
                                res += dp[z - l][o][1]
                                res %= MOD
                    else:
                        for l in range(1, min(o, limit) + 1):
                            if o - l >= 0:
                                res += dp[z][o - l][0]
                                res %= MOD
                    dp[z][o][k] = res

        return (dp[zero][one][0] + dp[zero][one][1]) % MOD