from collections import Counter
from math import factorial

class Solution:
    def countTheNumberofWinningSequences(self, n: int, k: int) -> int:
        MOD = 10**9 + 7
        fact = [1] * (n + 1)
        for i in range(2, n + 1):
            fact[i] = (fact[i - 1] * i) % MOD

        def inv(x):
            return pow(x, MOD - 2, MOD)

        def combinations(n, k):
            if k < 0 or k > n:
                return 0
            return (fact[n] * inv(fact[k]) * inv(fact[n - k])) % MOD

        num_same = min(n - k, k - 1)
        return (combinations(k, n - k + 1) * fact[n]) % MOD