class Solution:
    def longestNiceSubarray(self, nums: List[int]) -> int:
        n = len(nums)
        max_len = 0
        left = 0
        bitmask = 0

        for right in range(n):
            while bitmask & nums[right]:
                bitmask ^= nums[left]
                left += 1
            bitmask |= nums[right]
            max_len = max(max_len, right - left + 1)

        return max_len