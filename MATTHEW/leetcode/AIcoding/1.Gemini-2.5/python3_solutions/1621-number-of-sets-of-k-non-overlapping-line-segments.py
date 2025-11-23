class Solution:
    def numberOfSets(self, n: int, k: int) -> int:
        MOD = 10**9 + 7

        # The problem asks for the number of ways to choose k non-overlapping line segments
        # from n points (0 to n-1).
        # A line segment is defined by two distinct points (i, j) where i < j.
        # Two segments (a, b) and (c, d) are non-overlapping if b < c or d < a.
        #
        # This problem can be rephrased as choosing 2k distinct points from the n available points.
        # Let these 2k chosen points, in increasing order, be p_1 < p_2 < ... < p_{2k}.
        # These points uniquely form k non-overlapping segments:
        # (p_1, p_2), (p_3, p_4), ..., (p_{2k-1}, p_{2k}).
        #
        # The non-overlapping condition (e_i < s_{i+1}) is satisfied because p_2 < p_3, p_4 < p_5, etc.
        # Conversely, any set of k non-overlapping segments (s_1, e_1), ..., (s_k, e_k)
        # can be ordered such that s_1 < e_1 < s_2 < e_2 < ... < s_k < e_k.
        # These 2k endpoints are distinct points from the n available points.
        #
        # Thus, there is a bijection between choosing k non-overlapping segments and choosing 2k distinct points.
        # The number of ways to choose 2k distinct points from n points is C(n, 2k).

        # If 2k > n, it's impossible to choose 2k distinct points from n points.
        # In this case, C(n, 2k) is 0.
        if 2 * k > n:
            return 0

        # We need to calculate C(n, 2k) modulo MOD.
        # C(N, K) = N! / (K! * (N-K)!) % MOD
        # N = n
        # K = 2k

        # Precompute factorials and inverse factorials modulo MOD.
        # The maximum value for N is n.
        fact = [1] * (n + 1)
        inv_fact = [1] * (n + 1)

        # Calculate factorials
        for i in range(1, n + 1):
            fact[i] = (fact[i-1] * i) % MOD

        # Calculate inverse factorial for n! using Fermat's Little Theorem: a^(MOD-2) % MOD
        inv_fact[n] = pow(fact[n], MOD - 2, MOD)

        # Calculate inverse factorials for i! from (n-1)! down to 0!
        # inv_fact[i] = inv_fact[i+1] * (i+1) % MOD
        for i in range(n - 1, -1, -1):
            inv_fact[i] = (inv_fact[i+1] * (i+1)) % MOD

        # Calculate C(n, 2k) = n! * (2k)!^(-1) * (n - 2k)!^(-1) % MOD
        numerator = fact[n]
        denominator = (inv_fact[2 * k] * inv_fact[n - 2 * k]) % MOD

        result = (numerator * denominator) % MOD
        return result