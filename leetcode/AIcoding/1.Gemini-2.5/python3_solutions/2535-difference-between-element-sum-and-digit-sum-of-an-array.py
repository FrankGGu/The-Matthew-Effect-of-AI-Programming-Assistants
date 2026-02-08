class Solution:
    def differenceOfSum(self, nums: list[int]) -> int:
        element_sum = 0
        digit_sum = 0

        for num in nums:
            element_sum += num

            temp_num = num
            while temp_num > 0:
                digit_sum += temp_num % 10
                temp_num //= 10

        return abs(element_sum - digit_sum)