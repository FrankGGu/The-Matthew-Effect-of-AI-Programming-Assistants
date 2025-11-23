class Solution:
    def smallestValue(self, n: int) -> int:

        while True:
            current_n = n
            sum_of_factors = 0

            # Find prime factors and sum them
            d = 2
            temp_n = current_n

            while d * d <= temp_n:
                while temp_n % d == 0:
                    sum_of_factors += d
                    temp_n //= d
                d += 1

            # If temp_n is still greater than 1, it is a prime factor itself
            if temp_n > 1:
                sum_of_factors += temp_n

            # If the sum of prime factors is the same as the current number, we've reached a fixed point
            if sum_of_factors == current_n:
                return current_n

            # Otherwise, update n and continue the process
            n = sum_of_factors