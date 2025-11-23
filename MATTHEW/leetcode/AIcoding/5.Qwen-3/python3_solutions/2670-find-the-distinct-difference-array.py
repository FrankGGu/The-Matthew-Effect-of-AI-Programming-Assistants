from typing import List

class Solution:
    def distinctDifferenceArray(self, nums: List[int]) -> List[int]:
        n = len(nums)
        result = []
        for i in range(n):
            left = nums[:i+1]
            right = nums[i+1:]
            unique_left = len(set(left))
            unique_right = len(set(right)) if right else 0
            result.append(unique_left - unique_right)
        return result