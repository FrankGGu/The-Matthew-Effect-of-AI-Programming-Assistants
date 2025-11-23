class Solution:
    def maxSum(self, nums: List[int]) -> int:
        max_sum = -1
        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                max_digit_i = max(str(nums[i]))
                max_digit_j = max(str(nums[j]))
                if max_digit_i == max_digit_j:
                    max_sum = max(max_sum, nums[i] + nums[j])
        return max_sum