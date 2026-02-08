class Solution:
    def longestSquareStreak(self, nums: List[int]) -> int:
        nums.sort()
        num_set = set(nums)
        max_streak = 0
        for num in nums:
            if num in num_set:
                streak = 1
                current = num
                while True:
                    next_val = current * current
                    if next_val in num_set:
                        streak += 1
                        num_set.remove(current)
                        current = next_val
                    else:
                        break
                max_streak = max(max_streak, streak)
        return max_streak if max_streak > 1 else -1