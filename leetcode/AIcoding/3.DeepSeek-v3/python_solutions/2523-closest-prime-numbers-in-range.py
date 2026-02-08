class Solution:
    def closestPrimes(self, left: int, right: int) -> List[int]:
        def sieve(limit):
            if limit < 2:
                return []
            sieve = [True] * (limit + 1)
            sieve[0] = sieve[1] = False
            for num in range(2, int(limit ** 0.5) + 1):
                if sieve[num]:
                    sieve[num*num : limit+1 : num] = [False] * len(sieve[num*num : limit+1 : num])
            return [i for i, is_prime in enumerate(sieve) if is_prime]

        primes = sieve(right)
        primes = [p for p in primes if p >= left]

        if len(primes) < 2:
            return [-1, -1]

        min_diff = float('inf')
        res = [-1, -1]
        for i in range(len(primes) - 1):
            diff = primes[i+1] - primes[i]
            if diff < min_diff:
                min_diff = diff
                res = [primes[i], primes[i+1]]
                if min_diff <= 2:
                    break
        return res