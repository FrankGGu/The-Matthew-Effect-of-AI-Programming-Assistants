import math

MOD = 10**9 + 7

class Solution:
    def waysToFillArray(self, queries: List[List[int]]) -> List[int]:
        max_k = 30
        max_n = 10000 + max_k

        # Precompute factorial, inverse factorial for combinations
        fact = [1] * (max_n + max_k)
        inv_fact = [1] * (max_n + max_k)

        for i in range(1, max_n + max_k):
            fact[i] = fact[i-1] * i % MOD

        inv_fact[max_n + max_k - 1] = pow(fact[max_n + max_k - 1], MOD-2, MOD)
        for i in range(max_n + max_k - 2, -1, -1):
            inv_fact[i] = inv_fact[i + 1] * (i + 1) % MOD

        # Precompute smallest prime factors for factorization
        spf = [0] * (10**4 + 1)
        for i in range(2, 10**4 + 1):
            if spf[i] == 0:
                spf[i] = i
                if i * i <= 10**4:
                    for j in range(i*i, 10**4 + 1, i):
                        if spf[j] == 0:
                            spf[j] = i

        def factorize(x):
            factors = {}
            while x > 1:
                p = spf[x]
                factors[p] = factors.get(p, 0) + 1
                x = x // p
            return factors

        def comb(n, k):
            if n < 0 or k < 0 or k > n:
                return 0
            return fact[n] * inv_fact[k] % MOD * inv_fact[n - k] % MOD

        res = []
        for n, k in queries:
            if k == 1:
                res.append(1)
                continue
            factors = factorize(k)
            ans = 1
            for p, cnt in factors.items():
                ans = ans * comb(n + cnt - 1, cnt) % MOD
            res.append(ans)
        return res