from typing import List

class Solution:
    def validSubarraySize(self, nums: List[int], minLimit: int, maxLimit: int) -> int:
        n = len(nums)
        for i in range(n):
            count = 0
            for j in range(i, n):
                if nums[j] < minLimit or nums[j] > maxLimit:
                    break
                count += 1
                if count >= 1:
                    return j - i + 1
        return -1