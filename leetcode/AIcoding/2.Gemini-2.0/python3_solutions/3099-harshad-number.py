class Solution:
    def isHarshad(self, n: int) -> bool:
        sum_digits = sum(int(digit) for digit in str(n))
        return n % sum_digits == 0