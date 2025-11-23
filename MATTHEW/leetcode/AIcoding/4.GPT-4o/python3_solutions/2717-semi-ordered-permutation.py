class Solution:
    def semiOrderedPermutation(self, nums: List[int]) -> int:
        n = len(nums)
        left = nums.index(1)
        right = nums.index(n)
        if left < right:
            return left + (n - right - 1)
        return left + (n - right - 1) - 1