class Solution:
    def longestSquareStreak(self, nums: List[int]) -> int:
        nums_set = set(nums)
        max_streak = 0
        nums_sorted = sorted(nums)

        for num in nums_sorted:
            current_streak = 1
            next_num = num * num
            while next_num in nums_set:
                current_streak += 1
                next_num *= next_num
            max_streak = max(max_streak, current_streak)

        return max_streak if max_streak >= 2 else -1