import bisect

class Solution:
    def maxValue(self, events: List[List[int]], k: int) -> int:
        events.sort()
        n = len(events)
        starts = [event[0] for event in events]
        dp = [[-1 for _ in range(k+1)] for _ in range(n)]

        def dfs(cur_index, count):
            if count == 0 or cur_index == n:
                return 0
            if dp[cur_index][count] != -1:
                return dp[cur_index][count]

            # Skip current event
            max_val = dfs(cur_index + 1, count)

            # Take current event
            next_index = bisect.bisect_right(starts, events[cur_index][2])
            current_value = events[cur_index][2]
            max_val = max(max_val, dfs(next_index, count - 1) + events[cur_index][2])

            dp[cur_index][count] = max_val
            return max_val

        return dfs(0, k)