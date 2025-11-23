import bisect

class Solution:
    def maxScore(self, intervals: list[list[int]]) -> int:
        # Sort intervals by their end times. If end times are equal, sort by start times.
        # This sorting is crucial for the dynamic programming approach.
        intervals.sort(key=lambda x: x[1])

        n = len(intervals)
        if n == 0:
            return 0

        # dp[i] will store the maximum score obtainable from a subset of non-overlapping
        # intervals chosen from intervals[0...i].
        dp = [0] * n

        # Base case: For the first interval, the maximum score is just its own score.
        dp[0] = intervals[0][2]

        for i in range(1, n):
            current_start, current_end, current_score = intervals[i]

            # Option 1: Do not include the current interval.
            # The maximum score is the same as the maximum score up to the previous interval.
            dp[i] = dp[i-1]

            # Option 2: Include the current interval.
            # To do this, we need to find the maximum score from a set of non-overlapping
            # intervals that end strictly before the current interval starts.

            # We perform a binary search to find the largest index `j` in `[0, i-1]`
            # such that `intervals[j][1] < current_start`.
            # This ensures that `intervals[j]` and `intervals[i]` do not overlap.

            prev_max_score_from_non_overlapping = 0

            low, high = 0, i - 1
            best_prev_idx = -1 # Stores the index of the latest non-overlapping interval found

            while low <= high:
                mid = (low + high) // 2
                if intervals[mid][1] < current_start:
                    best_prev_idx = mid
                    low = mid + 1 # Try to find an even later non-overlapping interval
                else:
                    high = mid - 1 # This interval overlaps or ends too late, search earlier

            if best_prev_idx != -1:
                prev_max_score_from_non_overlapping = dp[best_prev_idx]

            # Calculate the score if the current interval is included
            score_if_included = current_score + prev_max_score_from_non_overlapping

            # Update dp[i] with the maximum of the two options (include or not include current interval)
            dp[i] = max(dp[i], score_if_included)

        return dp[n-1]