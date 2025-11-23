from collections import defaultdict

class Solution:
    def maxSubarrayLength(self, nums: list[int], k: int) -> int:
        freq = defaultdict(int)
        left = 0
        max_len = 0
        for right, num in enumerate(nums):
            freq[num] += 1
            while freq[num] > k:
                freq[nums[left]] -= 1
                left += 1
            max_len = max(max_len, right - left + 1)
        return max_len