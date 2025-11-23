from collections import Counter
import heapq

class Solution:
    def rearrangeBarcodes(self, barcodes: List[int]) -> List[int]:
        count = Counter(barcodes)
        max_freq = max(count.values())
        max_char = [k for k, v in count.items() if v == max_freq][0]

        result = [0] * len(barcodes)
        index = 0

        for char, freq in count.items():
            for _ in range(freq):
                if index >= len(barcodes):
                    index = 1
                result[index] = char
                index += 2

        return result