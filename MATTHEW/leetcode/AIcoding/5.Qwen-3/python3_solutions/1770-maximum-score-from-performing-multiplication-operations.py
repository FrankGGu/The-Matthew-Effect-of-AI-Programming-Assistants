class Solution:
    def maximumScore(self, nums: List[int], multipliers: List[int]) -> int:
        from functools import lru_cache

        n = len(nums)
        m = len(multipliers)

        @lru_cache(None)
        def dp(i, left):
            if i == m:
                return 0
            right = n - 1 - (i - left)
            return max(nums[left] * multipliers[i] + dp(i + 1, left + 1), nums[right] * multipliers[i] + dp(i + 1, left))

        return dp(0, 0)