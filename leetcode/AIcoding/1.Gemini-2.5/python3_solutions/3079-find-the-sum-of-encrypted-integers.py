class Solution:
    def sumOfEncryptedInt(self, nums: list[int]) -> int:
        total_sum = 0
        for num in nums:
            s_num = str(num)
            max_digit_char = '0'
            for digit_char in s_num:
                if digit_char > max_digit_char:
                    max_digit_char = digit_char

            num_digits = len(s_num)

            encrypted_s = max_digit_char * num_digits
            encrypted_num = int(encrypted_s)

            total_sum += encrypted_num

        return total_sum