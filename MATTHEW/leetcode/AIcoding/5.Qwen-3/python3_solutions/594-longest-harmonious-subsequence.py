from collections import Counter
from typing import List

class Solution:
    def longestHarmonicSubsequence(self, nums: List[int]) -> int:
        count = Counter(nums)
        max_length = 0
        for num in count:
            if num + 1 in count:
                max_length = max(max_length, count[num] + count[num + 1])
        return max_length