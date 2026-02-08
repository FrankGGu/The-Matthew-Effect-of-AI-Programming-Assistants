import collections
import heapq

class Solution:
    def reorganizeString(self, s: str) -> str:
        n = len(s)
        counts = collections.Counter(s)

        for char, freq in counts.items():
            if freq > (n + 1) // 2:
                return ""

        pq = [(-freq, char) for char, freq in counts.items()]
        heapq.heapify(pq)

        result = []

        while len(pq) >= 2:
            freq1, char1 = heapq.heappop(pq)
            freq2, char2 = heapq.heappop(pq)

            result.append(char1)
            result.append(char2)

            freq1 += 1
            freq2 += 1

            if freq1 < 0:
                heapq.heappush(pq, (freq1, char1))
            if freq2 < 0:
                heapq.heappush(pq, (freq2, char2))

        if pq:
            freq, char = heapq.heappop(pq)
            result.append(char)

        return "".join(result)