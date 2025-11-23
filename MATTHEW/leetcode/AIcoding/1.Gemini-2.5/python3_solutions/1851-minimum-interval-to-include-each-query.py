import heapq

class Solution:
    def minInterval(self, intervals: list[list[int]], queries: list[int]) -> list[int]:
        intervals.sort()

        # Store queries with their original indices to reconstruct the answer
        indexed_queries = sorted([(q, i) for i, q in enumerate(queries)])

        ans = [-1] * len(queries)

        # Min-heap to store (length, end_point) of intervals
        # The heap will be ordered by length
        min_heap = [] 

        interval_ptr = 0
        num_intervals = len(intervals)

        for q_val, q_idx in indexed_queries:
            # Add all intervals that start at or before the current query point
            while interval_ptr < num_intervals and intervals[interval_ptr][0] <= q_val:
                L, R = intervals[interval_ptr]
                heapq.heappush(min_heap, (R - L + 1, R))
                interval_ptr += 1

            # Remove intervals from the heap that do not cover the current query point
            # These are intervals whose end_point is less than the current query point
            while min_heap and min_heap[0][1] < q_val:
                heapq.heappop(min_heap)

            # If there are any valid intervals left in the heap, the top one has the minimum length
            if min_heap:
                ans[q_idx] = min_heap[0][0]

        return ans