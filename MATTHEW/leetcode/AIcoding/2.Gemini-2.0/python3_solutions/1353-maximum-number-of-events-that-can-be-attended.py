import heapq

class Solution:
    def maxEvents(self, events: list[list[int]]) -> int:
        events.sort()
        pq = []
        day = 0
        event_idx = 0
        count = 0

        while pq or event_idx < len(events):
            if not pq:
                day = events[event_idx][0]

            while event_idx < len(events) and events[event_idx][0] <= day:
                heapq.heappush(pq, events[event_idx][1])
                event_idx += 1

            heapq.heappop(pq)
            count += 1
            day += 1

            while pq and pq[0] < day:
                heapq.heappop(pq)

        return count