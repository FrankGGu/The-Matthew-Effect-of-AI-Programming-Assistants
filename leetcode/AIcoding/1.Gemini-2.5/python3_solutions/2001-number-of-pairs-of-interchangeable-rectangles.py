import math
from collections import Counter

class Solution:
    def interchangeableRectangles(self, rectangles: list[list[int]]) -> int:
        ratio_counts = Counter()
        for w, h in rectangles:
            common_divisor = math.gcd(w, h)
            simplified_w = w // common_divisor
            simplified_h = h // common_divisor
            ratio_counts[(simplified_w, simplified_h)] += 1

        total_pairs = 0
        for count in ratio_counts.values():
            if count > 1:
                total_pairs += (count * (count - 1)) // 2

        return total_pairs