class Solution:
    def smallestDivisibleDigitProduct(self, n: int) -> int:
        if n == 0:
            return -1  # Product of positive digits (1-9) cannot be 0.
        if n == 1:
            return 1

        digits = []
        # Iterate from 9 down to 2 to find the largest possible factors first.
        # This strategy helps to minimize the number of digits in the resulting number.
        for d in range(9, 1, -1):
            while n % d == 0:
                digits.append(d)
                n //= d

        # If n is not 1 after the factorization loop, it means that n still contains
        # prime factors greater than 9 (e.g., 11, 13, 17, etc.), or n itself was a prime > 9.
        # In such cases, it's impossible to form n as a product of digits from 1 to 9.
        if n != 1:
            return -1

        # To form the smallest possible number from the collected digits,
        # sort them in ascending order.
        digits.sort()

        # Join the sorted digits to form a string, then convert it to an integer.
        result_str = "".join(map(str, digits))
        return int(result_str)