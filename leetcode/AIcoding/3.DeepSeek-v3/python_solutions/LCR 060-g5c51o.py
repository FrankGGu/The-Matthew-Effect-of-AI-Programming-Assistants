import heapq
from collections import defaultdict

class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        frequency = defaultdict(int)
        for num in nums:
            frequency[num] += 1

        heap = []
        for num, count in frequency.items():
            heapq.heappush(heap, (-count, num))

        result = []
        for _ in range(k):
            result.append(heapq.heappop(heap)[1])

        return result