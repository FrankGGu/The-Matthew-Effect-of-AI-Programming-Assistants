from collections import Counter

class Solution:
    def rearrangeBarcodes(self, barcodes: List[int]) -> List[int]:
        count = Counter(barcodes)
        max_heap = [(-freq, num) for num, freq in count.items()]
        heapq.heapify(max_heap)

        result = []
        prev_freq, prev_num = 0, None

        while max_heap:
            freq, num = heapq.heappop(max_heap)
            result.append(num)
            if prev_freq < 0:
                heapq.heappush(max_heap, (prev_freq, prev_num))
            prev_freq, prev_num = freq + 1, num

        return result