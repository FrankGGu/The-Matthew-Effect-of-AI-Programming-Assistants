from collections import Counter
from typing import List

class Solution:
    def minSetSize(self, arr: List[int]) -> int:
        count = Counter(arr)
        sorted_counts = sorted(count.values(), reverse=True)
        res = 0
        total = 0
        for c in sorted_counts:
            total += c
            res += 1
            if total >= len(arr) // 2:
                return res
        return res