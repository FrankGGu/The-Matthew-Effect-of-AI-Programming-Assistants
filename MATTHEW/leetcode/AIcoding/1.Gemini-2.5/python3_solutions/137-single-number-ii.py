class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        result = 0
        for i in range(32):
            sum_bits = 0
            for num in nums:
                sum_bits += (num >> i) & 1

            if sum_bits % 3 == 1:
                result |= (1 << i)

        # Handle negative numbers for 32-bit signed integers.
        # If the 31st bit (most significant bit for a 32-bit signed int) is set,
        # the number is negative. Python's integers are arbitrary precision,
        # so a value like 0xFFFFFFFF (all 32 bits set) would be 2^32 - 1.
        # To get the 32-bit signed equivalent (-1), we subtract 2^32.
        if result >= (1 << 31):
            result -= (1 << 32)

        return result