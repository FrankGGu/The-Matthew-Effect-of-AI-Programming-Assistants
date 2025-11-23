import heapq
from collections import Counter

class Solution:
    def rearrangeBarcodes(self, barcodes: list[int]) -> list[int]:
        counts = Counter(barcodes)
        heap = []
        for num, count in counts.items():
            heapq.heappush(heap, (-count, num))

        result = []
        while heap:
            count1, num1 = heapq.heappop(heap)
            result.append(num1)

            if heap:
                count2, num2 = heapq.heappop(heap)
                result.append(num2)
                if count2 + 1 < 0:
                    heapq.heappush(heap, (count2 + 1, num2))

            if count1 + 1 < 0:
                heapq.heappush(heap, (count1 + 1, num1))

        return result