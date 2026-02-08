class Solution:
    def closestPrimes(self, left: int, right: int) -> List[int]:
        def is_prime(n):
            if n < 2:
                return False
            for i in range(2, int(n**0.5) + 1):
                if n % i == 0:
                    return False
            return True

        primes = []
        for num in range(max(left, 2), right + 1):
            if is_prime(num):
                primes.append(num)

        if len(primes) < 2:
            return [-1, -1]

        closest_pair = [-1, -1]
        min_diff = float('inf')

        for i in range(len(primes) - 1):
            diff = primes[i + 1] - primes[i]
            if diff < min_diff:
                min_diff = diff
                closest_pair = [primes[i], primes[i + 1]]

        return closest_pair