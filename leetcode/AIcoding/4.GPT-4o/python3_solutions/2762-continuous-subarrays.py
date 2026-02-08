class Solution:
    def continuousSubarrays(self, nums: List[int]) -> int:
        left = 0
        count = 0
        for right in range(len(nums)):
            while left < right and (max(nums[left:right+1]) - min(nums[left:right+1]) > 2):
                left += 1
            count += right - left + 1
        return count