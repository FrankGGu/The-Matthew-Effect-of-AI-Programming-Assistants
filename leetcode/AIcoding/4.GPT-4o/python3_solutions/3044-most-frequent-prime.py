from collections import Counter
from sympy import primerange

class Solution:
    def mostFrequentPrime(self, nums: List[int]) -> int:
        prime_count = Counter()
        for num in nums:
            for prime in primerange(2, num + 1):
                if num % prime == 0:
                    prime_count[prime] += 1
        return max(prime_count, key=lambda x: (prime_count[x], x), default=-1)