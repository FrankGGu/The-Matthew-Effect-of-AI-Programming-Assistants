import math

class Solution:
    def countPairs(self, nums: list[int], k: int) -> int:
        ans = 0
        # freq_multiples[d] stores the count of numbers encountered so far (nums[j] for j < i)
        # that are multiples of d.
        # The maximum value for d can be k.
        freq_multiples = [0] * (k + 1)

        for num in nums:
            # Step 1: Calculate required_factor for num
            # We need (num * other_num) % k == 0
            # Let g = gcd(num, k)
            # We need other_num % (k / g) == 0
            g = math.gcd(num, k)
            required_factor = k // g

            # Step 2: Add to answer based on freq_multiples
            # We need to find how many numbers encountered so far (j < current index)
            # are multiples of required_factor.
            # This is exactly what freq_multiples[required_factor] stores.
            ans += freq_multiples[required_factor]

            # Step 3: Update freq_multiples for the current num
            # For every divisor 'd' of 'num', we increment freq_multiples[d].
            # We only care about divisors 'd' that are <= k, because freq_multiples array is of size k+1.

            # Iterate through possible divisors d from 1 up to sqrt(num)
            sqrt_num = int(math.sqrt(num))
            for d in range(1, sqrt_num + 1):
                if num % d == 0:
                    # d is a divisor of num
                    if d <= k:
                        freq_multiples[d] += 1

                    # num // d is also a divisor of num
                    other_d = num // d
                    # Ensure other_d is not the same as d (e.g., for perfect squares)
                    # and other_d is within the bounds of freq_multiples array
                    if other_d != d and other_d <= k:
                        freq_multiples[other_d] += 1

        return ans