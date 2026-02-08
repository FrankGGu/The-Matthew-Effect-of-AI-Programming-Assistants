class Solution:
    def zeroFilledSubarrays(self, nums: list[int]) -> int:
        total_subarrays = 0
        current_zero_streak = 0

        for num in nums:
            if num == 0:
                current_zero_streak += 1
            else:
                total_subarrays += current_zero_streak * (current_zero_streak + 1) // 2
                current_zero_streak = 0

        # Add any remaining zero streak at the end of the array
        total_subarrays += current_zero_streak * (current_zero_streak + 1) // 2

        return total_subarrays