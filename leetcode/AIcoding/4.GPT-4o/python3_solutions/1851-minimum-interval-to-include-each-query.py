import heapq

class Solution:
    def minInterval(self, intervals: List[List[int]], queries: List[int]) -> List[int]:
        intervals.sort(key=lambda x: x[0])
        queries_with_index = sorted([(q, i) for i, q in enumerate(queries)])
        result = [-1] * len(queries)
        min_heap = []
        idx = 0

        for q, original_index in queries_with_index:
            while idx < len(intervals) and intervals[idx][0] <= q:
                heapq.heappush(min_heap, (intervals[idx][1] - intervals[idx][0] + 1, intervals[idx][1]))
                idx += 1

            while min_heap and min_heap[0][1] < q:
                heapq.heappop(min_heap)

            if min_heap:
                result[original_index] = min_heap[0][0]

        return result