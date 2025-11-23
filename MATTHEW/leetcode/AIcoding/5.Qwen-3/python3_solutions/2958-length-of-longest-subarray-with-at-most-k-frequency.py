class Solution:
    def longestSubarray(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        left = 0
        max_len = 0

        for right in range(len(nums)):
            count[nums[right]] += 1

            while count[nums[right]] > k:
                count[nums[left]] -= 1
                left += 1

            max_len = max(max_len, right - left + 1)

        return max_len