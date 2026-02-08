class Solution:
    def maxProduct(self, nums: list[int]) -> int:
        max_ending_here = nums[0]
        min_ending_here = nums[0]
        overall_max = nums[0]

        for i in range(1, len(nums)):
            current_num = nums[i]

            temp_max_ending_here = max_ending_here

            max_ending_here = max(current_num, temp_max_ending_here * current_num, min_ending_here * current_num)
            min_ending_here = min(current_num, temp_max_ending_here * current_num, min_ending_here * current_num)

            overall_max = max(overall_max, max_ending_here)

        return overall_max