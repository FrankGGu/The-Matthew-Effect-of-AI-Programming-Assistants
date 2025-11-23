from typing import List

class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        required = set(range(1, n + 1))
        seen = set()
        operations = 0
        i = n - 1
        while i >= 0 and len(required) > 0:
            if nums[i] in required:
                required.remove(nums[i])
            operations += 1
            i -= 1
        return operations