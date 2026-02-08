class Solution:
    def nthSuperUglyNumber(self, n: int, primes: list[int]) -> int:
        if n == 1:
            return 1

        dp = [0] * n
        dp[0] = 1

        k = len(primes)
        pointers = [0] * k

        next_multiples = list(primes)

        for i in range(1, n):
            min_val = float('inf')
            for j in range(k):
                min_val = min(min_val, next_multiples[j])

            dp[i] = min_val

            for j in range(k):
                if next_multiples[j] == min_val:
                    pointers[j] += 1
                    next_multiples[j] = primes[j] * dp[pointers[j]]

        return dp[n-1]