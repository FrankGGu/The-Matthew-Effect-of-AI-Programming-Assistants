import bisect

class Solution:
    def findRightInterval(self, intervals: list[list[int]]) -> list[int]:
        n = len(intervals)

        # Step 1: Create a list of tuples (start_time, end_time, original_index).
        # This is necessary to keep track of the original positions after sorting.
        indexed_intervals = []
        for i in range(n):
            indexed_intervals.append((intervals[i][0], intervals[i][1], i))

        # Step 2: Sort the indexed_intervals list based on their start times.
        # This allows for efficient binary search to find the "right" interval.
        indexed_intervals.sort()

        # Step 3: Create a separate list containing only the start times from the sorted intervals.
        # This list will be used with bisect_left for efficient searching.
        sorted_starts = [interval[0] for interval in indexed_intervals]

        # Step 4: Initialize the result array with -1s.
        # The result array will store the original index of the right interval
        # for each interval in the *original* input order.
        result = [-1] * n

        # Step 5: Iterate through the *original* input intervals to find the right interval for each.
        for i in range(n):
            # Get the end time of the current interval from the original input.
            current_end = intervals[i][1]

            # Use bisect_left to find the index of the first start time in `sorted_starts`
            # that is greater than or equal to `current_end`.
            # `idx` will be the insertion point for `current_end` to maintain sorted order.
            idx = bisect.bisect_left(sorted_starts, current_end)

            # Check if a suitable right interval was found.
            # If `idx` is less than `n`, it means `sorted_starts[idx]` is a valid start time
            # and it is the smallest start time that is >= `current_end`.
            if idx < n:
                # The corresponding interval in `indexed_intervals` is `indexed_intervals[idx]`.
                # Its original index is stored at `indexed_intervals[idx][2]`.
                # We store this original index in `result` at the current interval's original position `i`.
                result[i] = indexed_intervals[idx][2]
            # If `idx == n`, it means no interval has a start time greater than or equal to `current_end`.
            # In this case, `result[i]` remains -1, which is the default value.

        return result