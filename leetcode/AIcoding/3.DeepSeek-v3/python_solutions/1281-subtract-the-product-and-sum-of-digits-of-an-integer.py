class Solution:
    def subtractProductAndSum(self, n: int) -> int:
        product = 1
        sum_digits = 0
        for digit in str(n):
            num = int(digit)
            product *= num
            sum_digits += num
        return product - sum_digits