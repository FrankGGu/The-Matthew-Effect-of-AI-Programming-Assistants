class Solution:
    def firstDayBeenInAllRooms(self, nextVisit: list[int]) -> int:
        n = len(nextVisit)
        dp = [0] * n

        for i in range(1, n):
            j = nextVisit[i-1]
            if j < i:
                dp[i] = (dp[i-1] + 1 + (dp[i-1] - dp[j] + 1)) % 1000000007
            else:
                dp[i] = (dp[i-1] + 1) % 1000000007

        return dp[n-1]