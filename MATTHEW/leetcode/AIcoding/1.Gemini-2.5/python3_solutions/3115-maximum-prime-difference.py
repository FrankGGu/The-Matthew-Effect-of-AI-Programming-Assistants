class Solution:
    def maximumPrimeDifference(self, nums: list[int]) -> int:
        max_val = 100
        is_prime = [True] * (max_val + 1)
        is_prime[0] = is_prime[1] = False
        for p in range(2, int(max_val**0.5) + 1):
            if is_prime[p]:
                for multiple in range(p * p, max_val + 1, p):
                    is_prime[multiple] = False

        first_prime_idx = -1
        last_prime_idx = -1

        for i, num in enumerate(nums):
            if is_prime[num]:
                if first_prime_idx == -1:
                    first_prime_idx = i
                last_prime_idx = i

        if first_prime_idx == -1: # No primes found
            return 0

        return last_prime_idx - first_prime_idx