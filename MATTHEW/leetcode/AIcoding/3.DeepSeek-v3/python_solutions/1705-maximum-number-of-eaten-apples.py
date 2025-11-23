import heapq

class Solution:
    def eatenApples(self, apples: List[int], days: List[int]) -> int:
        heap = []
        res = 0
        n = len(apples)

        for i in range(n + max(days)):
            if i < n and apples[i] > 0:
                heapq.heappush(heap, (i + days[i], apples[i]))

            while heap:
                rot, count = heap[0]
                if rot <= i or count == 0:
                    heapq.heappop(heap)
                else:
                    break

            if heap:
                rot, count = heap[0]
                if count > 0:
                    res += 1
                    new_count = count - 1
                    heapq.heappop(heap)
                    if new_count > 0:
                        heapq.heappush(heap, (rot, new_count))

        return res