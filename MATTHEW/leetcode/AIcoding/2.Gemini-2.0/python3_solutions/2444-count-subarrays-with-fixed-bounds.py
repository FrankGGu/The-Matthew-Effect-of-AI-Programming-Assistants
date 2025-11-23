class Solution:
    def countSubarrays(self, nums: list[int], minK: int, maxK: int) -> int:
        res = 0
        min_idx = -1
        max_idx = -1
        left = -1
        for i, num in enumerate(nums):
            if num < minK or num > maxK:
                left = i
            if num == minK:
                min_idx = i
            if num == maxK:
                max_idx = i
            res += max(0, min(min_idx, max_idx) - left)
        return res