class Solution:
    def countDigits(self, num: int) -> int:
        count = 0
        temp_num = num
        while temp_num > 0:
            digit = temp_num % 10
            if digit != 0 and num % digit == 0:
                count += 1
            temp_num //= 10
        return count