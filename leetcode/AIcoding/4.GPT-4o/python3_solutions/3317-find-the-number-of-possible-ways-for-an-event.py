class Solution:
    def countWays(self, events: List[List[int]]) -> int:
        events.sort()
        dp = [0] * (len(events) + 1)
        dp[0] = 1
        mod = 10**9 + 7

        for i in range(1, len(events) + 1):
            for j in range(i):
                if events[j][1] < events[i - 1][0]:
                    dp[i] = (dp[i] + dp[j]) % mod
                elif j == i - 1:
                    dp[i] = (dp[i] + 1) % mod

        return sum(dp) % mod