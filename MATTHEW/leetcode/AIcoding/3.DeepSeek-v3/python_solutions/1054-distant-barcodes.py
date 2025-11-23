import heapq
from collections import defaultdict

class Solution:
    def rearrangeBarcodes(self, barcodes: List[int]) -> List[int]:
        count = defaultdict(int)
        for num in barcodes:
            count[num] += 1

        max_heap = []
        for num, cnt in count.items():
            heapq.heappush(max_heap, (-cnt, num))

        res = []
        prev_cnt, prev_num = 0, 0

        while max_heap:
            cnt, num = heapq.heappop(max_heap)
            res.append(num)
            cnt += 1

            if prev_cnt < 0:
                heapq.heappush(max_heap, (prev_cnt, prev_num))

            prev_cnt, prev_num = cnt, num

        return res