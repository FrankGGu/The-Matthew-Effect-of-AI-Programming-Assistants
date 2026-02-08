class Solution {
    private static final int MOD = 1_000_000_007;

    public int maxNiceDivisors(int primeFactors) {
        if (primeFactors <= 3) {
            return primeFactors;
        }
        int quotient = primeFactors / 3;
        int remainder = primeFactors % 3;
        if (remainder == 0) {
            return (int) pow(3, quotient);
        } else if (remainder == 1) {
            return (int) ((pow(3, quotient - 1) * 4) % MOD);
        } else {
            return (int) ((pow(3, quotient) * 2) % MOD);
        }
    }

    private long pow(long base, int exponent) {
        long result = 1;
        while (exponent > 0) {
            if (exponent % 2 == 1) {
                result = (result * base) % MOD;
            }
            base = (base * base) % MOD;
            exponent /= 2;
        }
        return result;
    }
}