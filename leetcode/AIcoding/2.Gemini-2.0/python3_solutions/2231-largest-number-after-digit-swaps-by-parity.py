class Solution:
    def largestInteger(self, num: int) -> int:
        s = str(num)
        odd_digits = []
        even_digits = []
        for digit in s:
            digit = int(digit)
            if digit % 2 == 0:
                even_digits.append(digit)
            else:
                odd_digits.append(digit)

        odd_digits.sort(reverse=True)
        even_digits.sort(reverse=True)

        odd_idx = 0
        even_idx = 0
        res = ""
        for digit in s:
            digit = int(digit)
            if digit % 2 == 0:
                res += str(even_digits[even_idx])
                even_idx += 1
            else:
                res += str(odd_digits[odd_idx])
                odd_idx += 1

        return int(res)