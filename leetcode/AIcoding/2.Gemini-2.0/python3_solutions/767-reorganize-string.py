import heapq
from collections import Counter

class Solution:
    def reorganizeString(self, s: str) -> str:
        counts = Counter(s)
        heap = [(-count, char) for char, count in counts.items()]
        heapq.heapify(heap)

        result = ""
        while len(heap) > 1:
            count1, char1 = heapq.heappop(heap)
            count2, char2 = heapq.heappop(heap)

            result += char1 + char2

            if count1 + 1 < 0:
                heapq.heappush(heap, (count1 + 1, char1))
            if count2 + 1 < 0:
                heapq.heappush(heap, (count2 + 1, char2))

        if heap:
            count, char = heapq.heappop(heap)
            if count < -1:
                return ""
            else:
                result += char

        return result