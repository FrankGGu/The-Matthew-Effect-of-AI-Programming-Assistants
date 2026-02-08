class Solution:
    def countSubarrays(self, nums: List[int], threshold: int) -> int:
        count = 0
        left = 0

        for right in range(len(nums)):
            if nums[right] > threshold:
                left = right + 1
            count += right - left + 1

        return count