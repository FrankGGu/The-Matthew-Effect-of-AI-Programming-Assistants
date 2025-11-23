class Solution:
    def maxNiceDivisors(self, primeFactors: int) -> int:
        MOD = 10**9 + 7

        # Let primeFactors be N. We want to construct a positive integer n.
        # Let the prime factorization of n be p_1^a_1 * p_2^a_2 * ... * p_k^a_k.
        # The total number of prime factors (counted with multiplicity) is a_1 + a_2 + ... + a_k.
        # This sum must be less than or equal to N.
        # To maximize the number of divisors, we should always use all N prime factors,
        # so a_1 + a_2 + ... + a_k = N.
        # The number of divisors of n is (a_1 + 1) * (a_2 + 1) * ... * (a_k + 1).
        # We need to maximize this product subject to a_i >= 1 for all i.

        # Consider an exponent a_i >= 2.
        # We can replace this a_i with (a_i - 1) and introduce a new exponent a_{k+1} = 1.
        # The sum of exponents remains the same: a_i = (a_i - 1) + 1.
        # The product of (exponent + 1) terms changes from (a_i + 1) to ((a_i - 1) + 1) * (1 + 1) = a_i * 2.
        #
        # Let's compare (a_i + 1) with (2 * a_i):
        # If a_i = 1, then 1 + 1 = 2, and 2 * 1 = 2. (This case is not relevant as we assume a_i >= 2)
        # If a_i = 2, then 2 + 1 = 3, and 2 * 2 = 4. Since 4 > 3, splitting increases the product.
        # If a_i = 3, then 3 + 1 = 4, and 2 * 3 = 6. Since 6 > 4, splitting increases the product.
        # In general, for any a_i >= 2:
        # The difference (2 * a_i) - (a_i + 1) = a_i - 1.
        # Since a_i >= 2, a_i - 1 >= 1.
        # Therefore, 2 * a_i > a_i + 1 for all a_i >= 2.
        #
        # This implies that if any exponent a_i is 2 or greater, we can always increase the total product
        # by replacing that a_i with (a_i - 1) and introducing a new exponent of 1. This new exponent 1
        # corresponds to using an additional distinct prime factor. Since the problem states "total count of prime factors",
        # we are free to use as many distinct prime factors as needed, as long as their exponents sum up to N.
        #
        # This process can be repeated until all exponents are 1.
        # If all exponents are 1, then a_1 = 1, a_2 = 1, ..., a_k = 1.
        # The sum of exponents is 1 * k = N. So, k must be equal to N.
        # The product of (a_i + 1) terms becomes (1+1) * (1+1) * ... * (1+1) (N times).
        # This is 2 * 2 * ... * 2 (N times), which equals 2^N.

        # The result needs to be modulo 10^9 + 7.
        return pow(2, primeFactors, MOD)