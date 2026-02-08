class Solution:
    def maxTwoEvents(self, events: list[list[int]]) -> int:
        events.sort()
        max_val = 0
        suffix_max = [0] * len(events)
        suffix_max[-1] = events[-1][2]
        for i in range(len(events) - 2, -1, -1):
            suffix_max[i] = max(suffix_max[i + 1], events[i][2])

        for i in range(len(events)):
            start, end, value = events[i]

            l, r = i + 1, len(events) - 1
            best_index = -1

            while l <= r:
                mid = (l + r) // 2
                if events[mid][0] > end:
                    best_index = mid
                    r = mid - 1
                else:
                    l = mid + 1

            if best_index != -1:
                max_val = max(max_val, value + suffix_max[best_index])
            else:
                max_val = max(max_val, value)

        return max_val