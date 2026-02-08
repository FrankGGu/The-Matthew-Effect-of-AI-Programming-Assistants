class Solution:
    def primePairs(self, n: int) -> List[List[int]]:
        def is_prime(num):
            if num < 2:
                return False
            for i in range(2, int(num ** 0.5) + 1):
                if num % i == 0:
                    return False
            return True

        primes = [i for i in range(2, n) if is_prime(i)]
        result = []

        prime_set = set(primes)
        for p in primes:
            if (n - p) in prime_set and p <= (n - p):
                result.append([p, n - p])

        return result