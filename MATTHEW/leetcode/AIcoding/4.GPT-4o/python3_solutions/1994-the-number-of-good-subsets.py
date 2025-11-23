from collections import Counter
from functools import lru_cache

class Solution:
    def numberOfGoodSubsets(self, nums):
        count = Counter(nums)
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
        mod = 10**9 + 7

        if count[1] > 0:
            total = pow(2, count[1], mod) - 1
        else:
            total = 0

        def prime_mask(n):
            mask = 0
            for i, prime in enumerate(primes):
                if n % prime == 0:
                    mask |= (1 << i)
                    while n % prime == 0:
                        n //= prime
            return mask if n == 1 else -1

        masks = []
        for num in count:
            mask = prime_mask(num)
            if mask != -1:
                masks.append((mask, count[num]))

        @lru_cache(None)
        def dfs(i, curr_mask):
            if i == len(masks):
                return 1
            total_ways = dfs(i + 1, curr_mask)
            mask, cnt = masks[i]
            if curr_mask & mask == 0:
                total_ways += dfs(i + 1, curr_mask | mask) * cnt
                total_ways %= mod
            return total_ways

        total += dfs(0, 0) - 1
        return total % mod