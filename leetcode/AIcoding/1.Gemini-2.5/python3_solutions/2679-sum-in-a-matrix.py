class Solution:
    def matrixSum(self, nums: list[list[int]]) -> int:
        for row in nums:
            row.sort()

        total_sum = 0
        num_rows = len(nums)
        num_cols = len(nums[0])

        for col_idx in range(num_cols):
            current_max_across_rows = 0
            for row_idx in range(num_rows):
                current_max_across_rows = max(current_max_across_rows, nums[row_idx][col_idx])
            total_sum += current_max_across_rows

        return total_sum