class Solution {
    long MOD = 1_000_000_007;

    public int minNonZeroProduct(int p) {
        if (p == 1) {
            return 1;
        }

        // The maximum value an element can take is (2^p - 1).
        // The number of elements in the array is (2^p - 1).

        // The strategy to minimize the product is to make one element as large as possible
        // and other elements as small as possible.
        // The optimal configuration involves:
        // 1. One element with value (2^p - 1).
        // 2. (2^(p-1) - 1) elements with value (2^p - 2).
        // 3. (2^(p-1) - 1) elements with value 1.
        // The total number of elements is 1 + (2^(p-1) - 1) + (2^(p-1) - 1) = 2^p - 1.
        // The product will be (2^p - 1) * (2^p - 2)^(2^(p-1) - 1) * 1^(2^(p-1) - 1).
        // Which simplifies to (2^p - 1) * (2^p - 2)^(2^(p-1) - 1).

        // Calculate (2^p - 1)
        long val1 = (1L << p) - 1; // This is the single largest element

        // Calculate (2^p - 2)
        long val2_base = (1L << p) - 2; // This is the base for the power term

        // Calculate the exponent for (2^p - 2)
        // The exponent is (2^(p-1) - 1)
        long val2_exp = (1L << (p - 1)) - 1;

        // Calculate the power term: (2^p - 2)^(2^(p-1) - 1) mod MOD
        long powerTerm = power(val2_base, val2_exp, MOD);

        // Calculate the final product: (val1 * powerTerm) mod MOD
        long result = (val1 % MOD * powerTerm) % MOD;

        return (int) result;
    }

    // Modular exponentiation (base^exp % mod)
    private long power(long base, long exp, long mod) {
        long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % mod;
            }
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
}