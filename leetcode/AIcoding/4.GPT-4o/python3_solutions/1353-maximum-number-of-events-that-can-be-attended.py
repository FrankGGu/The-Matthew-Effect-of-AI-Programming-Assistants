class Solution:
    def maxEvents(self, events: List[List[int]]) -> int:
        events.sort(key=lambda x: (x[0], x[1]))
        day = 0
        count = 0
        heap = []

        for start, end in events:
            while heap and heap[0] < day + 1:
                heapq.heappop(heap)
            day = max(day, start)
            if day <= end:
                heapq.heappush(heap, end)
                count += 1
                day += 1

        return count