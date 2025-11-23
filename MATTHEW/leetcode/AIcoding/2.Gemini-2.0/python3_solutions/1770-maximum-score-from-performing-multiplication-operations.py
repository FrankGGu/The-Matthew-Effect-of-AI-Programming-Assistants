class Solution:
    def maximumScore(self, nums: list[int], multipliers: list[int]) -> int:
        n = len(nums)
        m = len(multipliers)
        dp = {}

        def solve(i, left):
            if i == m:
                return 0
            if (i, left) in dp:
                return dp[(i, left)]

            right = n - 1 - (i - left)

            dp[(i, left)] = max(
                multipliers[i] * nums[left] + solve(i + 1, left + 1),
                multipliers[i] * nums[right] + solve(i + 1, left)
            )
            return dp[(i, left)]

        return solve(0, 0)