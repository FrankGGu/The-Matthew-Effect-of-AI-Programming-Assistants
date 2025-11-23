class Solution:
    def countDigits(self, num: int) -> int:
        count = 0
        s = str(num)
        for digit in s:
            digit = int(digit)
            if digit != 0 and num % digit == 0:
                count += 1
        return count