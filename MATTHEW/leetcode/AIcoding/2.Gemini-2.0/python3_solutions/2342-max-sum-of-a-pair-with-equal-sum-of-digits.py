class Solution:
    def maxSum(self, nums: list[int]) -> int:
        digit_sums = {}
        max_sum = -1
        for num in nums:
            digit_sum = sum(int(digit) for digit in str(num))
            if digit_sum in digit_sums:
                max_sum = max(max_sum, digit_sums[digit_sum] + num)
                digit_sums[digit_sum] = max(digit_sums[digit_sum], num)
            else:
                digit_sums[digit_sum] = num
        return max_sum