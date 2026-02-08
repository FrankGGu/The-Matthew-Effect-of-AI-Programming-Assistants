import heapq

class Solution:
    def fillCups(self, amount: List[int]) -> int:
        max_heap = []
        for num in amount:
            if num > 0:
                heapq.heappush(max_heap, -num)

        time = 0
        while len(max_heap) > 1:
            first = -heapq.heappop(max_heap)
            second = -heapq.heappop(max_heap)
            first -= 1
            second -= 1
            time += 1
            if first > 0:
                heapq.heappush(max_heap, -first)
            if second > 0:
                heapq.heappush(max_heap, -second)

        if max_heap:
            time += -max_heap[0]

        return time