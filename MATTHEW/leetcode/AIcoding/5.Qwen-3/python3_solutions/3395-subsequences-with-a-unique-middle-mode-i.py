from typing import List
from collections import Counter

class Solution:
    def countSubseqWithUniqueMin(self, nums: List[int]) -> int:
        n = len(nums)
        count = 0
        for i in range(n):
            freq = Counter()
            min_val = nums[i]
            for j in range(i, n):
                freq[nums[j]] += 1
                if nums[j] < min_val:
                    min_val = nums[j]
                if freq[min_val] == 1:
                    count += 1
        return count