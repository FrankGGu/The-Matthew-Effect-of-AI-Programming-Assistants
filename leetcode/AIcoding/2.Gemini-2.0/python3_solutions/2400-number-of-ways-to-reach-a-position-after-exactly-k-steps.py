class Solution:
    def numberOfWays(self, startPos: int, endPos: int, k: int) -> int:
        MOD = 10**9 + 7

        @lru_cache(None)
        def dp(currPos, remainingSteps):
            if remainingSteps == 0:
                return 1 if currPos == endPos else 0

            if abs(currPos - endPos) > remainingSteps:
                return 0

            ways = (dp(currPos + 1, remainingSteps - 1) + dp(currPos - 1, remainingSteps - 1)) % MOD
            return ways

        from functools import lru_cache
        return dp(startPos, k)