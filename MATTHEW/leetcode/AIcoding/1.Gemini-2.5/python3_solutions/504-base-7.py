class Solution:
    def convertToBase7(self, num: int) -> str:
        if num == 0:
            return "0"

        is_negative = False
        if num < 0:
            is_negative = True
            num = -num

        result = []
        while num > 0:
            result.append(str(num % 7))
            num //= 7

        if is_negative:
            result.append("-")

        return "".join(result[::-1])