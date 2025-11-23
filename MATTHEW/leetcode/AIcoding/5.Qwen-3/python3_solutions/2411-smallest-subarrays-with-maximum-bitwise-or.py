class Solution:
    def maximumSubarrayOr(self, nums: List[int]) -> int:
        n = len(nums)
        result = 0
        for i in range(n):
            current_or = 0
            for j in range(i, n):
                current_or |= nums[j]
                result = max(result, current_or)
        return result