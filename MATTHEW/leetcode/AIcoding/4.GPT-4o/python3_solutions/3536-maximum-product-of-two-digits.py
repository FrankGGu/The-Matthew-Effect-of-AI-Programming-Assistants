class Solution:
    def maxProduct(self, n: int) -> int:
        max_digit = 0
        while n > 0:
            max_digit = max(max_digit, n % 10)
            n //= 10
        return (max_digit - 1) * max_digit