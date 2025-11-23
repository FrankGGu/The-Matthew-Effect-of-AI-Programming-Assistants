class Solution:
    def maxValue(self, events: List[List[int]], k: int) -> int:
        events.sort()
        n = len(events)
        dp = {}

        def solve(idx, count):
            if count == 0 or idx == n:
                return 0

            if (idx, count) in dp:
                return dp[(idx, count)]

            next_idx = -1
            l, r = idx + 1, n - 1
            while l <= r:
                mid = (l + r) // 2
                if events[mid][0] > events[idx][1]:
                    next_idx = mid
                    r = mid - 1
                else:
                    l = mid + 1

            if next_idx == -1:
                dp[(idx, count)] = events[idx][2]
                return events[idx][2]

            dp[(idx, count)] = max(events[idx][2] + solve(next_idx, count - 1), solve(idx + 1, count))
            return dp[(idx, count)]

        return solve(0, k)