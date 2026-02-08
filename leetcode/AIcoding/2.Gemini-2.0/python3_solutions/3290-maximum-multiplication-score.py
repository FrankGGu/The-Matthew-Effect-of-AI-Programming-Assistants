class Solution:
    def maximumScore(self, nums: List[int], multipliers: List[int]) -> int:
        n = len(nums)
        m = len(multipliers)

        @lru_cache(None)
        def solve(i, left):
            if i == m:
                return 0

            right = n - 1 - (i - left)

            return max(multipliers[i] * nums[left] + solve(i + 1, left + 1),
                       multipliers[i] * nums[right] + solve(i + 1, left))

        return solve(0, 0)