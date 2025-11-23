class Solution:
    def maxSum(self, nums: List[int]) -> int:
        max_digits = {}
        max_sum = -1

        for num in nums:
            max_d = max(str(num))
            if max_d in max_digits:
                max_sum = max(max_sum, num + max_digits[max_d])
                max_digits[max_d] = max(max_digits[max_d], num)
            else:
                max_digits[max_d] = num

        return max_sum