import heapq

class Solution:
    def minInterval(self, intervals, queries):
        intervals.sort()
        queries = sorted((q, i) for i, q in enumerate(queries))
        result = [0] * len(queries)
        min_heap = []

        i = 0
        for q, idx in queries:
            while i < len(intervals) and intervals[i][0] <= q:
                heapq.heappush(min_heap, (intervals[i][1] - intervals[i][0] + 1, intervals[i][1]))
                i += 1
            while min_heap and min_heap[0][1] < q:
                heapq.heappop(min_heap)
            if min_heap:
                result[idx] = min_heap[0][0]
            else:
                result[idx] = -1
        return result