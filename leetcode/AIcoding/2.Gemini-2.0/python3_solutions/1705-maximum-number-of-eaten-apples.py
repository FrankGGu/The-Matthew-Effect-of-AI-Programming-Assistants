import heapq

class Solution:
    def eatenApples(self, apples: list[int], days: list[int]) -> int:
        n = len(apples)
        heap = []
        eaten = 0
        i = 0
        while i < n or heap:
            while heap and heap[0][0] <= i:
                heapq.heappop(heap)
            if i < n and apples[i] > 0:
                heapq.heappush(heap, (i + days[i], apples[i]))
            if heap:
                expiry, count = heapq.heappop(heap)
                eaten += 1
                count -= 1
                if count > 0 and expiry > i + 1:
                    heapq.heappush(heap, (expiry, count))
            i += 1
        return eaten