import heapq

class Solution:
    def getSkyline(self, buildings: list[list[int]]) -> list[list[int]]:
        events = []
        for l, r, h in buildings:
            events.append((l, -h, r))
            events.append((r, 0, 0))
        events.sort()

        heap = [(0, float('inf'))]
        result = []
        prev_height = 0

        for x, h, r in events:
            while heap and heap[0][1] <= x:
                heapq.heappop(heap)

            if h < 0:
                heapq.heappush(heap, (h, r))

            curr_height = -heap[0][0]
            if curr_height != prev_height:
                result.append([x, curr_height])
                prev_height = curr_height

        return result