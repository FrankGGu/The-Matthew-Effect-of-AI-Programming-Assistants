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

        def is_valid(x):
            product = digit_product(x)
            return product != 0 and x % product == 0

        x = n + 1
        while True:
            if is_valid(x):
                return x
            x += 1