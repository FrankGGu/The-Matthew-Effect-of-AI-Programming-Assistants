class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        count = 0
        n = len(nums)
        left = 0

        for right in range(n):
            while left <= right and (nums[left] & k) != k:
                left += 1
            count += right - left + 1

        return count