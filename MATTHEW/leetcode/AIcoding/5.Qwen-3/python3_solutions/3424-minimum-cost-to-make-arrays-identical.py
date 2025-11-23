from typing import List
from collections import Counter

class Solution:
    def minCost(self, nums: List[int], cost: List[int], target: int) -> int:
        count = Counter()
        for num in nums:
            count[num] += 1
        res = 0
        for num in count:
            res += abs(num - target) * count[num]
        return res