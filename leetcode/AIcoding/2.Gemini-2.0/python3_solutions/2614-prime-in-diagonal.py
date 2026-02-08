class Solution:
    def diagonalPrime(self, nums: List[List[int]]) -> int:
        def is_prime(n):
            if n <= 1:
                return False
            for i in range(2, int(n**0.5) + 1):
                if n % i == 0:
                    return False
            return True

        n = len(nums)
        primes = []
        for i in range(n):
            if is_prime(nums[i][i]):
                primes.append(nums[i][i])
            if i != n - 1 - i and is_prime(nums[i][n - 1 - i]):
                primes.append(nums[i][n - 1 - i])

        if not primes:
            return 0
        else:
            return max(primes)