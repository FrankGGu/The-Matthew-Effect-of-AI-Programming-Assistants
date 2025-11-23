class Solution:
    def maxFrequency(self, nums: list[int], k: int) -> int:
        nums.sort()
        left, right = 0, 0
        total = 0
        max_freq = 0
        while right < len(nums):
            total += nums[right]
            while (right - left + 1) * nums[right] - total > k:
                total -= nums[left]
                left += 1
            max_freq = max(max_freq, right - left + 1)
            right += 1
        return max_freq