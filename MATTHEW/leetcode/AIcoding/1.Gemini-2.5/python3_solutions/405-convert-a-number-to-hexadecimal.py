class Solution:
    def toHex(self, num: int) -> str:
        if num == 0:
            return "0"

        hex_digits = "0123456789abcdef"
        result = []

        if num < 0:
            num += 2**32  # Convert to unsigned 32-bit representation

        while num > 0:
            remainder = num % 16
            result.append(hex_digits[remainder])
            num //= 16

        return "".join(result[::-1])