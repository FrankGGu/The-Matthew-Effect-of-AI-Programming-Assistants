import heapq
from collections import defaultdict

class Solution:
    def minSetSize(self, arr: List[int]) -> int:
        freq = defaultdict(int)
        for num in arr:
            freq[num] += 1

        max_heap = []
        for count in freq.values():
            heapq.heappush(max_heap, -count)

        total = 0
        res = 0
        while total < len(arr) // 2:
            total += -heapq.heappop(max_heap)
            res += 1

        return res