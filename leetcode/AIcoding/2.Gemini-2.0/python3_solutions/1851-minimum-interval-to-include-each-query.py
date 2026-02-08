import heapq

class Solution:
    def minInterval(self, intervals: list[list[int]], queries: list[int]) -> list[int]:
        intervals.sort()
        queries_with_index = sorted([(q, i) for i, q in enumerate(queries)])
        result = [-1] * len(queries)
        heap = []
        i = 0
        for query, index in queries_with_index:
            while i < len(intervals) and intervals[i][0] <= query:
                l, r = intervals[i]
                heapq.heappush(heap, (r - l + 1, r))
                i += 1
            while heap and heap[0][1] < query:
                heapq.heappop(heap)
            if heap:
                result[index] = heap[0][0]
        return result