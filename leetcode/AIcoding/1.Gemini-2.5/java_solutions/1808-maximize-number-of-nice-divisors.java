class Solution {
    private static final int MOD = 1_000_000_007;

    public int maxNiceDivisors(int primeFactors) {
        // The problem asks to maximize the number of divisors of a positive integer 'n',
        // given that 'n' has exactly 'primeFactors' total prime factors (counting multiplicities).
        // Let the prime factorization of 'n' be p1^a1 * p2^a2 * ... * pk^ak,
        // where p1, ..., pk are distinct prime numbers and a1, ..., ak are their exponents.

        // The total count of prime factors is the sum of the exponents:
        // a1 + a2 + ... + ak = primeFactors.
        // Each exponent ai must be at least 1 (since pi are prime factors).

        // The number of divisors of 'n' is given by the product:
        // (a1 + 1) * (a2 + 1) * ... * (ak + 1).
        // Our goal is to maximize this product, subject to the sum constraint and ai >= 1.

        // Let's analyze the effect of splitting an exponent.
        // Consider an exponent 'A' such that A >= 2. We can split 'A' into two smaller positive integers, say 'x' and 'y',
        // such that x + y = A, and x, y >= 1.
        // If we keep the exponent as 'A', its contribution to the product of (ai+1) terms is (A+1).
        // If we split 'A' into 'x' and 'y', their contributions to the product are (x+1) and (y+1).
        // We compare (x+1)(y+1) with (x+y+1).
        // (x+1)(y+1) = xy + x + y + 1.
        // (x+y+1) = x + y + 1.
        // Since x >= 1 and y >= 1, their product xy is always positive (xy >= 1).
        // Therefore, (x+1)(y+1) = xy + (x+y+1) > (x+y+1).

        // This inequality implies that it is always better to split an exponent 'A' (where A >= 2)
        // into two or more smaller exponents (e.g., A = x+y) than to keep it as a single exponent.
        // This splitting process can continue until all exponents 'ai' are equal to 1.

        // For example:
        // If an exponent is 2: (2+1) = 3. Splitting into 1+1 gives (1+1)(1+1) = 2*2 = 4. (4 > 3, so splitting is better).
        // If an exponent is 3: (3+1) = 4. Splitting into 1+1+1 gives (1+1)(1+1)(1+1) = 2*2*2 = 8. (8 > 4, so splitting is better).

        // Thus, to maximize the product (a1+1)...(ak+1) given sum(ai) = primeFactors,
        // the optimal strategy is to set all exponents ai = 1.
        // This means we choose 'primeFactors' distinct prime numbers (e.g., 2, 3, 5, ...),
        // and raise each to the power of 1.
        // So, n = p1^1 * p2^1 * ... * p(primeFactors)^1.
        // The number of divisors will be (1+1) * (1+1) * ... * (1+1) (primeFactors times).
        // This simplifies to 2^primeFactors.

        // We need to compute 2^primeFactors modulo 10^9 + 7.
        return (int) power(2, primeFactors);
    }

    // Modular exponentiation function (base^exp % MOD)
    private long power(long base, int exp) {
        long res = 1;
        base %= MOD; // Ensure base is within modulo range
        while (exp > 0) {
            if (exp % 2 == 1) { // If exponent is odd, multiply result by base
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD; // Square the base
            exp /= 2; // Halve the exponent
        }
        return res;
    }
}