from typing import List

class Solution:
    def findTheArrayConcaterationValue(self, nums: List[int]) -> int:
        n = len(nums)
        left = 0
        right = n - 1
        res = 0
        while left <= right:
            if left == right:
                res += nums[left]
            else:
                res += int(str(nums[left]) + str(nums[right]))
            left += 1
            right -= 1
        return res