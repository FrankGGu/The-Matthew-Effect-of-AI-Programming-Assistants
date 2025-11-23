class Solution:
    def countSubarrays(self, nums: List[int], l: int, r: int) -> int:
        n = len(nums)
        total = 0
        left = 0

        for right in range(n):
            while left <= right and (nums[right] < l or nums[right] > r):
                left += 1
            total += right - left + 1

        return total