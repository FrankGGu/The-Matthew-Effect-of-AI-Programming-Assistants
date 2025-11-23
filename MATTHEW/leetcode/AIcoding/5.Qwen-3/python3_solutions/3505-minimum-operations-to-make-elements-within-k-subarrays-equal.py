from collections import defaultdict
from typing import List

class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        n = len(nums)
        count = defaultdict(int)
        for i in range(n):
            if i < k:
                count[nums[i]] += 1
        res = 0
        for i in range(k, n):
            if count[nums[i - k]] == 1:
                del count[nums[i - k]]
            else:
                count[nums[i - k]] -= 1
            count[nums[i]] += 1
            res += len(count)
        return res