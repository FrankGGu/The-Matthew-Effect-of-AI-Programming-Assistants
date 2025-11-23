import functools

class Solution:
    def maximumScore(self, nums: list[int], multipliers: list[int]) -> int:
        n = len(nums)
        m = len(multipliers)

        @functools.lru_cache(None)
        def dp(i: int, left: int) -> int:
            if i == m:
                return 0

            # Calculate the index of the rightmost available element in nums
            # Total elements taken so far: i
            # Elements taken from left: left
            # Elements taken from right: i - left
            # The rightmost available element is at index n - 1 - (number of elements taken from right)
            right = n - 1 - (i - left)

            # Option 1: Take from the left side of nums
            score_if_take_left = multipliers[i] * nums[left] + dp(i + 1, left + 1)

            # Option 2: Take from the right side of nums
            score_if_take_right = multipliers[i] * nums[right] + dp(i + 1, left)

            return max(score_if_take_left, score_if_take_right)

        return dp(0, 0)