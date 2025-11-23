class Solution:
    def firstDayBeenInAllRooms(self, nextVisit: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nextVisit)
        dp = [0] * n
        dp[0] = 0

        for i in range(1, n):
            dp[i] = (dp[i - 1] + 2) % MOD

        for i in range(1, n):
            dp[i] = (dp[i] + dp[nextVisit[i]]) % MOD

        return dp[-1]