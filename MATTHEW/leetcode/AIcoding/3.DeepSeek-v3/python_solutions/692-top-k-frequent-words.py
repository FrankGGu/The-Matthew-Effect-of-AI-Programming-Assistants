import heapq
from collections import defaultdict

class Solution:
    def topKFrequent(self, words: List[str], k: int) -> List[str]:
        freq = defaultdict(int)
        for word in words:
            freq[word] += 1

        heap = []
        for word, count in freq.items():
            heapq.heappush(heap, (-count, word))

        result = []
        for _ in range(k):
            result.append(heapq.heappop(heap)[1])

        return result