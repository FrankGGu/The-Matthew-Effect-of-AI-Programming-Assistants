class Solution:
    def smallestNumber(self, num: int) -> int:
        if num == 0:
            return 0
        digits = list(str(abs(num)))
        if num > 0:
            digits.sort()
            i = 0
            while i < len(digits) and digits[i] == '0':
                i += 1
            if i < len(digits):
                digits[0], digits[i] = digits[i], digits[0]
            return int(''.join(digits))
        else:
            digits.sort(reverse=True)
            return -int(''.join(digits))