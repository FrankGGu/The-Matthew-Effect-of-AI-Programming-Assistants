class Solution:
    def longestSquareStreak(self, nums: List[int]) -> int:
        nums = set(nums)
        longest = 0

        for num in nums:
            if num - 1 not in nums:
                streak = 0
                while num in nums:
                    streak += 1
                    num += 1
                longest = max(longest, streak)

        return longest if longest > 1 else -1