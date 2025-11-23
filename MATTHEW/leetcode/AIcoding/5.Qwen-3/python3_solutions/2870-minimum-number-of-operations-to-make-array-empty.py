from collections import Counter
from typing import List

class Solution:
    def minOperations(self, nums: List[int]) -> int:
        count = Counter(nums)
        res = 0
        for v in count.values():
            if v == 1:
                return -1
            res += v // 3
            if v % 3 != 0:
                res += 1
        return res