class Solution:
    def countSubarrays(self, nums: List[int], minK: int, maxK: int) -> int:
        count = 0
        left = 0
        n = len(nums)

        for right in range(n):
            if nums[right] < minK or nums[right] > maxK:
                left = right + 1
            if nums[right] >= minK and nums[right] <= maxK:
                count += right - left + 1

        return count