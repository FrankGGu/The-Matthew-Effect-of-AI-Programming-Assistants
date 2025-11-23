class Solution:
    def numberOfGoodSubsets(self, nums: List[int]) -> int:
        from collections import Counter
        MOD = 10**9 + 7
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
        count = Counter(nums)

        # Precompute the prime factors for numbers 1 to 30
        prime_factors = {}
        for num in range(1, 31):
            if num == 1:
                prime_factors[num] = []
                continue
            factors = []
            tmp = num
            for p in primes:
                if tmp % p == 0:
                    factors.append(p)
                    while tmp % p == 0:
                        tmp //= p
            if tmp == 1:
                prime_factors[num] = factors
            else:
                prime_factors[num] = None

        # Initialize DP
        dp = [0] * (1 << len(primes))
        dp[0] = 1

        for num in range(2, 31):
            if count[num] == 0 or prime_factors[num] is None:
                continue
            mask = 0
            for p in prime_factors[num]:
                mask |= (1 << primes.index(p))
            for prev_mask in range((1 << len(primes)) - 1, -1, -1):
                if (prev_mask & mask) == 0:
                    dp[prev_mask | mask] = (dp[prev_mask | mask] + dp[prev_mask] * count[num]) % MOD

        total = 0
        for mask in range(1, 1 << len(primes)):
            total = (total + dp[mask]) % MOD

        # Multiply by 2^count[1] (since 1s can be included or not)
        return total * pow(2, count[1], MOD) % MOD