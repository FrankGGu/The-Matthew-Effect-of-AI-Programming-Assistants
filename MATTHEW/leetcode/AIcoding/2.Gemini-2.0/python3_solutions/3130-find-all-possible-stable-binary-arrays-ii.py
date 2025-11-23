class Solution:
    def numberOfWays(self, n: int, k: int) -> int:
        MOD = 10**9 + 7
        dp = {}

        def solve(idx, zeros, ones, last):
            if idx == n:
                if ones == k:
                    return 1
                else:
                    return 0

            if (idx, zeros, ones, last) in dp:
                return dp[(idx, zeros, ones, last)]

            ans = 0

            # Place a 0
            ans = (ans + solve(idx + 1, zeros + 1, ones, 0)) % MOD

            # Place a 1
            if last == 0:
                ans = (ans + solve(idx + 1, zeros, ones + 1, 1)) % MOD

            dp[(idx, zeros, ones, last)] = ans
            return ans

        return solve(0, 0, 0, 0)