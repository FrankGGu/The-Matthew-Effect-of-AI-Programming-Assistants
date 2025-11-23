import heapq

class Solution:
    def minGroups(self, intervals: list[list[int]]) -> int:
        intervals.sort()
        heap = []
        count = 0
        for interval in intervals:
            start, end = interval
            if heap and heap[0] <= start:
                heapq.heappop(heap)
            else:
                count += 1
            heapq.heappush(heap, end)
        return count