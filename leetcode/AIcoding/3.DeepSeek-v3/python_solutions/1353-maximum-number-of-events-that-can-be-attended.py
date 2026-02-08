import heapq

class Solution:
    def maxEvents(self, events: List[List[int]]) -> int:
        events.sort()
        max_day = max(end for start, end in events)
        heap = []
        res = 0
        event_ptr = 0
        n = len(events)

        for day in range(1, max_day + 1):
            while event_ptr < n and events[event_ptr][0] == day:
                heapq.heappush(heap, events[event_ptr][1])
                event_ptr += 1

            while heap and heap[0] < day:
                heapq.heappop(heap)

            if heap:
                heapq.heappop(heap)
                res += 1

        return res