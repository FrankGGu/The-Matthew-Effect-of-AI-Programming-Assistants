class Solution:
    def countDivisibleByLastDigit(self, s: str) -> int:
        last_digit = int(s[-1])
        count = 0

        for i in range(len(s)):
            num = int(s[i:])
            if last_digit != 0 and num % last_digit == 0:
                count += 1

        return count