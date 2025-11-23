class Solution:
    def maximumPrimeDifference(self, nums: List[int]) -> int:
        def is_prime(n):
            if n < 2:
                return False
            for i in range(2, int(n ** 0.5) + 1):
                if n % i == 0:
                    return False
            return True

        primes = []
        for i, num in enumerate(nums):
            if is_prime(num):
                primes.append(i)

        if len(primes) < 2:
            return 0
        return primes[-1] - primes[0]