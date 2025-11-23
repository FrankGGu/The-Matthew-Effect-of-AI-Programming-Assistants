import heapq

class Solution:
    def maxFreeTime(self, schedule: List[List[int]]) -> int:
        intervals = []
        for person in schedule:
            for interval in person:
                intervals.append(interval)

        intervals.sort()
        heap = []
        max_gap = 0

        for interval in intervals:
            if heap and heap[0] <= interval[0]:
                prev_end = heapq.heappop(heap)
                gap = interval[0] - prev_end
                if gap > max_gap:
                    max_gap = gap
            heapq.heappush(heap, interval[1])

        return max_gap