from collections import Counter
import heapq

class Solution:
    def topKFrequent(self, words, k: int):
        count = Counter(words)
        heap = [(-freq, word) for word, freq in count.items()]
        heapq.heapify(heap)
        return [heapq.heappop(heap)[1] for _ in range(k)]