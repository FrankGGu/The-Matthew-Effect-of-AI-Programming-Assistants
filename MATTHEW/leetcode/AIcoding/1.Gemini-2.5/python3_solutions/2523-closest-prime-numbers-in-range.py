import math

class Solution:
    def closestPrimes(self, left: int, right: int) -> list[int]:
        is_prime = [True] * (right + 1)
        if right >= 0:
            is_prime[0] = False
        if right >= 1:
            is_prime[1] = False

        for p in range(2, int(math.sqrt(right)) + 1):
            if is_prime[p]:
                for multiple in range(p * p, right + 1, p):
                    is_prime[multiple] = False

        primes_in_range = []
        for i in range(left, right + 1):
            if is_prime[i]:
                primes_in_range.append(i)

        if len(primes_in_range) < 2:
            return [-1, -1]

        min_diff = float('inf')
        result = [-1, -1]

        for i in range(len(primes_in_range) - 1):
            num1 = primes_in_range[i]
            num2 = primes_in_range[i+1]
            current_diff = num2 - num1

            if current_diff < min_diff:
                min_diff = current_diff
                result = [num1, num2]

            # Optimization: if min_diff is 2, we can't do better, so return
            if min_diff == 2:
                return result

        return result