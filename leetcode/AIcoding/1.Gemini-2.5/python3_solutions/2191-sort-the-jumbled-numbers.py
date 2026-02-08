class Solution:
    def sortJumbled(self, mapping: list[int], nums: list[int]) -> list[int]:

        transformed_nums = []

        for i, num in enumerate(nums):
            jumbled_value = 0

            if num == 0:
                jumbled_value = mapping[0]
            else:
                temp_num = num
                power_of_10 = 1
                while temp_num > 0:
                    digit = temp_num % 10
                    mapped_digit = mapping[digit]
                    jumbled_value = mapped_digit * power_of_10 + jumbled_value
                    power_of_10 *= 10
                    temp_num //= 10

            transformed_nums.append((jumbled_value, i, num))

        transformed_nums.sort()

        result = [item[2] for item in transformed_nums]

        return result