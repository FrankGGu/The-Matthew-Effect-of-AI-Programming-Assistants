class Solution:
    def sumOfLargestPrimeSubstrings(self, s: str) -> int:
        def is_prime(n):
            if n < 2:
                return False
            for i in range(2, int(n**0.5) + 1):
                if n % i == 0:
                    return False
            return True

        max_primes = []

        for i in range(len(s)):
            for j in range(i + 1, len(s) + 1):
                num = int(s[i:j])
                if is_prime(num):
                    max_primes.append(num)

        return sum(max_primes)