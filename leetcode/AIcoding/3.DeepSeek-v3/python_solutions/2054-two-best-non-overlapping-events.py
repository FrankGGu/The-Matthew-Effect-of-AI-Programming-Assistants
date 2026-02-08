class Solution:
    def maxTwoEvents(self, events: List[List[int]]) -> int:
        events.sort()
        n = len(events)
        max_values = [0] * (n + 1)
        for i in range(n - 1, -1, -1):
            max_values[i] = max(max_values[i + 1], events[i][2])

        max_total = 0
        for i in range(n):
            current_val = events[i][2]
            left, right = i + 1, n - 1
            next_idx = n
            while left <= right:
                mid = (left + right) // 2
                if events[mid][0] > events[i][1]:
                    next_idx = mid
                    right = mid - 1
                else:
                    left = mid + 1
            max_total = max(max_total, current_val + max_values[next_idx])

        return max_total