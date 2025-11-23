from typing import List

class Solution:
    def findSumPairs(self, nums1: List[int], nums2: List[int], target: int) -> int:
        count = 0
        freq = {}
        for num in nums2:
            if num in freq:
                freq[num] += 1
            else:
                freq[num] = 1
        for num in nums1:
            complement = target - num
            if complement in freq:
                count += freq[complement]
        return count