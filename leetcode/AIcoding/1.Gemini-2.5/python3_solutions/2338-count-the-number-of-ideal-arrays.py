import math

MOD = 10**9 + 7
MAX_VAL = 10000
MAX_COMB_N_VAL = MAX_VAL + 14 # 10000 + 14 = 10014

fact = [1] * (MAX_COMB_N_VAL + 1)
inv_fact = [1] * (MAX_COMB_N_VAL + 1)
spf = [0] * (MAX_VAL + 1) # Smallest Prime Factor

def precompute_factorials():
    for i in range(1, MAX_COMB_N_VAL + 1):
        fact[i] = (fact[i-1] * i) % MOD
    inv_fact[MAX_COMB_N_VAL] = pow(fact[MAX_COMB_N_VAL], MOD - 2, MOD)
    for i in range(MAX_COMB_N_VAL - 1, -1, -1):
        inv_fact[i] = (inv_fact[i+1] * (i+1)) % MOD

def nCr_mod_p(n_comb, r_comb):
    if r_comb < 0 or r_comb > n_comb:
        return 0
    return (((fact[n_comb] * inv_fact[r_comb]) % MOD) * inv_fact[n_comb - r_comb]) % MOD

def sieve():
    for i in range(2, MAX_VAL + 1):
        if spf[i] == 0: # i is prime
            spf[i] = i
            # Mark multiples of i
            # Optimization: start from i*i because smaller multiples would have been marked by smaller primes
            for multiple in range(i * i, MAX_VAL + 1, i):
                if spf[multiple] == 0: # Only mark if not already marked by a smaller prime
                    spf[multiple] = i

precompute_factorials()
sieve()

class Solution:
    def idealArrays(self, n: int, maxValue: int) -> int:

        total_ideal_arrays = 0

        # If n=1, any number from 1 to maxValue forms an ideal array of length 1.
        # So there are maxValue such arrays.
        # The general formula also handles this: k_comb = n-1 = 0.
        # C(exponent + 0, 0) = C(exponent, 0) = 1.
        # So ways_for_v becomes 1 for each v, and sum(1) from 1 to maxValue is maxValue.
        # This special case is not strictly necessary but can be a minor optimization or clarity.
        if n == 1:
            return maxValue

        # k_comb is the number of 'bars' in the stars and bars problem, which is n-1.
        # The number of ways to distribute 'exponent' items into 'n' bins (y_0, ..., y_{n-1})
        # is C(exponent + n - 1, n - 1). Here, n-1 is the k_comb parameter.
        k_comb = n - 1 

        for v in range(1, maxValue + 1):
            current_v = v
            ways_for_v = 1

            # Factorize v using precomputed smallest prime factors (spf)
            # This loop runs for log(v) iterations (number of prime factors)
            while current_v > 1:
                p = spf[current_v]
                exponent = 0
                while current_v % p == 0:
                    exponent += 1
                    current_v //= p

                # For each prime factor p raised to 'exponent' in v,
                # calculate the number of ways to distribute this exponent across n terms
                # (a_1, a_2/a_1, ..., a_n/a_{n-1}).
                # This is C(exponent + n - 1, n - 1)
                ways_for_v = (ways_for_v * nCr_mod_p(exponent + k_comb, k_comb)) % MOD

            total_ideal_arrays = (total_ideal_arrays + ways_for_v) % MOD

        return total_ideal_arrays