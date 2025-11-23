import heapq

class Solution:
    def maxEvents(self, events: list[list[int]]) -> int:
        events.sort()

        n = len(events)
        attended_count = 0

        min_heap = [] 

        event_ptr = 0

        max_end_day = 0
        if events:
            max_end_day = max(event[1] for event in events)

        for day in range(1, max_end_day + 1):
            while event_ptr < n and events[event_ptr][0] == day:
                heapq.heappush(min_heap, events[event_ptr][1])
                event_ptr += 1

            while min_heap and min_heap[0] < day:
                heapq.heappop(min_heap)

            if min_heap:
                heapq.heappop(min_heap)
                attended_count += 1

            if event_ptr == n and not min_heap:
                break

        return attended_count