class Solution:
    def countSubarrays(self, nums: list[int], k: int) -> int:
        count = 0
        left = 0
        current_sum = 0
        for right in range(len(nums)):
            current_sum += nums[right]
            while current_sum * (right - left + 1) >= k and left <= right:
                current_sum -= nums[left]
                left += 1
            count += right - left + 1
        return count