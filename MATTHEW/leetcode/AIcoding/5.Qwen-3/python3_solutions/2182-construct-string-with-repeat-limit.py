class Solution:
    def repeatLimitedQueue(self, s: str, repeatLimit: int) -> str:
        from collections import Counter
        import heapq

        count = Counter(s)
        max_heap = []
        for char, freq in count.items():
            heapq.heappush(max_heap, (-ord(char), freq))

        result = []

        while max_heap:
            neg_ord1, freq1 = heapq.heappop(max_heap)
            char1 = chr(-neg_ord1)

            if not result or result[-1] != char1:
                result.append(char1)
                freq1 -= 1
                if freq1 > 0:
                    heapq.heappush(max_heap, (neg_ord1, freq1))
            else:
                if not max_heap:
                    break
                neg_ord2, freq2 = heapq.heappop(max_heap)
                char2 = chr(-neg_ord2)
                result.append(char2)
                freq2 -= 1
                if freq2 > 0:
                    heapq.heappush(max_heap, (neg_ord2, freq2))
                heapq.heappush(max_heap, (neg_ord1, freq1))

        return ''.join(result)