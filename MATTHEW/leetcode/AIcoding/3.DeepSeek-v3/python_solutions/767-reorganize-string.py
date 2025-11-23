import heapq
from collections import Counter

class Solution:
    def reorganizeString(self, S: str) -> str:
        count = Counter(S)
        max_heap = [(-cnt, char) for char, cnt in count.items()]
        heapq.heapify(max_heap)

        res = []
        prev_cnt, prev_char = 0, ''

        while max_heap:
            cnt, char = heapq.heappop(max_heap)
            res.append(char)
            if prev_cnt < 0:
                heapq.heappush(max_heap, (prev_cnt, prev_char))
            prev_cnt, prev_char = cnt + 1, char

        if len(res) != len(S):
            return ""
        return ''.join(res)