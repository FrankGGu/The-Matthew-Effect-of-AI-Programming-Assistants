import bisect

class Solution:
    def maxTwoEvents(self, events: list[list[int]]) -> int:
        events.sort()

        n = len(events)
        ans = 0

        end_time_to_max_val = {}
        for s, e, v in events:
            end_time_to_max_val[e] = max(end_time_to_max_val.get(e, 0), v)

        prefix_max_values = []
        current_max = 0

        sorted_unique_end_times = sorted(end_time_to_max_val.keys())

        for t in sorted_unique_end_times:
            current_max = max(current_max, end_time_to_max_val[t])
            prefix_max_values.append((t, current_max))

        for s, e, v in events:
            ans = max(ans, v)

            idx = bisect.bisect_left(prefix_max_values, (s, -1))

            if idx > 0:
                max_val_before_s = prefix_max_values[idx-1][1]
                ans = max(ans, v + max_val_before_s)

        return ans