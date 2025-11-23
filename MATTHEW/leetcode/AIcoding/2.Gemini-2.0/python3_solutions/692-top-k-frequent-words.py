import heapq
from collections import Counter

class Solution:
    def topKFrequent(self, words: list[str], k: int) -> list[str]:
        count = Counter(words)
        heap = [(-freq, word) for word, freq in count.items()]
        heapq.heapify(heap)

        result = []
        for _ in range(k):
            freq, word = heapq.heappop(heap)
            result.append(word)

        return result