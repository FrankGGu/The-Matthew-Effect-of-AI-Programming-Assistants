class Solution:
    def countEven(self, num: int) -> int:
        count = 0
        for i in range(1, num + 1):
            s = str(i)
            digit_sum = 0
            for digit in s:
                digit_sum += int(digit)
            if digit_sum % 2 == 0:
                count += 1
        return count