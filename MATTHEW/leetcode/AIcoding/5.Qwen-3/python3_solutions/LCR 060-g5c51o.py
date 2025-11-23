from typing import List
import heapq
from collections import Counter

class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        count = Counter(nums)
        heap = []
        for num, freq in count.items():
            heapq.heappush(heap, (-freq, num))
        result = []
        for _ in range(k):
            result.append(heapq.heappop(heap)[1])
        return result