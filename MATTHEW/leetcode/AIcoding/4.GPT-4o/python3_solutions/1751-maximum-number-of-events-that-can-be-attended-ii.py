class Solution:
    def maxValue(self, events: List[List[int]], k: int) -> int:
        events.sort(key=lambda x: x[1])
        n = len(events)
        dp = [[0] * (k + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            start, end, value = events[i - 1]
            for j in range(1, k + 1):
                dp[i][j] = dp[i - 1][j]
                l = 0
                r = i - 1
                while l < r:
                    mid = (l + r) // 2
                    if events[mid][1] < start:
                        l = mid + 1
                    else:
                        r = mid
                if l == r and events[l][1] >= start:
                    l -= 1
                if l >= 0:
                    dp[i][j] = max(dp[i][j], dp[l + 1][j - 1] + value)

        return dp[n][k]