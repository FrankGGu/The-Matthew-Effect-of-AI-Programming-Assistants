import math

class Solution:
    def sumFourDivisors(self, nums: list[int]) -> int:
        total_sum_of_divisors = 0

        for n in nums:
            # Numbers less than 6 cannot have exactly four divisors.
            # 1: 1 divisor
            # 2, 3, 5: 2 divisors (prime)
            # 4: 3 divisors (1, 2, 4)
            if n < 6:
                continue

            divisors_count = 0
            current_num_divisors_sum = 0

            # Iterate from 1 up to sqrt(n) to find divisors
            limit = int(math.sqrt(n))

            for i in range(1, limit + 1):
                if n % i == 0:
                    # i is a divisor
                    divisors_count += 1
                    current_num_divisors_sum += i

                    # n // i is also a divisor, unless i*i == n
                    if i * i != n:
                        divisors_count += 1
                        current_num_divisors_sum += (n // i)

                # Optimization: If we've already found more than 4 divisors,
                # this number does not qualify, so we can stop early.
                if divisors_count > 4:
                    break

            # If the number has exactly four divisors, add their sum to the total.
            if divisors_count == 4:
                total_sum_of_divisors += current_num_divisors_sum

        return total_sum_of_divisors