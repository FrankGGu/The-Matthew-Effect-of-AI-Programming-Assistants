class Solution:
    def smallestDivisibleDigitProduct(self, n: int) -> int:
        def digit_product(x):
            product = 1
            while x > 0:
                digit = x % 10
                if digit == 0:
                    return 0
                product *= digit
                x = x // 10
            return product

        for num in range(1, 10**6 + 1):
            if num % n == 0:
                product = digit_product(num)
                if product != 0 and product % n == 0:
                    return num
        return -1