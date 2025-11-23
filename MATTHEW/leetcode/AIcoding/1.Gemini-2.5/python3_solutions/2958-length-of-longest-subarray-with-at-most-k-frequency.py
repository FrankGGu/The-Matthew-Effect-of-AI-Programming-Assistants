import collections

class Solution:
    def maxSubarrayLength(self, nums: list[int], k: int) -> int:
        n = len(nums)
        left = 0
        max_len = 0
        freq = collections.defaultdict(int)

        for right in range(n):
            freq[nums[right]] += 1
            while freq[nums[right]] > k:
                freq[nums[left]] -= 1
                left += 1
            max_len = max(max_len, right - left + 1)

        return max_len