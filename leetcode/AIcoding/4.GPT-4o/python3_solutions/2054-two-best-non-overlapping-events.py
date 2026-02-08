class Solution:
    def maxTwoEvents(self, events: List[List[int]]) -> int:
        events.sort(key=lambda x: x[1])
        dp = [0] * (len(events) + 1)
        event_end = []

        for start, end, value in events:
            event_end.append((end, value))

        for i in range(1, len(events) + 1):
            dp[i] = max(dp[i - 1], event_end[i - 1][1])

        max_value = 0
        for i in range(len(events)):
            start, end, value = events[i]
            j = bisect.bisect_right(event_end, (start, float('inf')))
            max_value = max(max_value, value + dp[j])

        return max_value