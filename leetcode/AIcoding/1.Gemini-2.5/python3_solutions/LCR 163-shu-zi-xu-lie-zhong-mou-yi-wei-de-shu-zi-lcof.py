class Solution:
    def findNthDigit(self, k: int) -> int:
        digits = 1
        count = 9
        start = 1

        while k > digits * count:
            k -= digits * count
            digits += 1
            count *= 10
            start *= 10

        num_index_in_block = (k - 1) // digits
        num = start + num_index_in_block

        digit_index_in_num = (k - 1) % digits

        return int(str(num)[digit_index_in_num])