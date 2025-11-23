import heapq

class Solution:
    def getSkyline(self, buildings: List[List[int]]) -> List[List[int]]:
        events = []
        for L, R, H in buildings:
            events.append((L, -H, R))
            events.append((R, 0, 0))

        events.sort()

        res = []
        heap = [(0, float('inf'))]
        heapq.heapify(heap)
        for x, negH, R in events:
            while heap[0][1] <= x:
                heapq.heappop(heap)
            if negH != 0:
                heapq.heappush(heap, (negH, R))
            if not res or res[-1][1] != -heap[0][0]:
                res.append([x, -heap[0][0]])
        return res