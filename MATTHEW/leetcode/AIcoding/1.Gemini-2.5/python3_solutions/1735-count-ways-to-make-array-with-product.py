class Solution:
    def waysToCreateProduct(self, queries: list[list[int]]) -> list[int]:
        MOD = 10**9 + 7

        # Max value for n in queries is 10^4
        # Max value for k in queries is 10^4
        # The maximum exponent for a prime factor in k (e.g., 2^13 = 8192, 2^14 = 16384) is 13 (for k <= 10^4).
        # We need to calculate combinations C(e + n - 1, n - 1).
        # Max value for (e + n - 1) is 13 + 10000 - 1 = 10012.
        # So, we need factorials up to 10012.
        MAX_COMB_N_VAL = 10012 

        fact = [1] * (MAX_COMB_N_VAL + 1)
        invFact = [1] * (MAX_COMB_N_VAL + 1)

        for i in range(1, MAX_COMB_N_VAL + 1):
            fact[i] = (fact[i-1] * i) % MOD

        invFact[MAX_COMB_N_VAL] = pow(fact[MAX_COMB_N_VAL], MOD - 2, MOD)

        for i in range(MAX_COMB_N_VAL - 1, -1, -1):
            invFact[i] = (invFact[i+1] * (i+1)) % MOD

        def nCr_mod_p(n_val, r_val):
            if r_val < 0 or r_val > n_val:
                return 0
            return (((fact[n_val] * invFact[r_val]) % MOD) * invFact[n_val - r_val]) % MOD

        results = []
        for n, k in queries:
            current_ways = 1
            temp_k = k

            d = 2
            while d * d <= temp_k:
                if temp_k % d == 0:
                    exponent = 0
                    while temp_k % d == 0:
                        exponent += 1
                        temp_k //= d

                    current_ways = (current_ways * nCr_mod_p(exponent + n - 1, n - 1)) % MOD
                d += 1

            if temp_k > 1:
                exponent = 1 
                current_ways = (current_ways * nCr_mod_p(exponent + n - 1, n - 1)) % MOD

            results.append(current_ways)

        return results