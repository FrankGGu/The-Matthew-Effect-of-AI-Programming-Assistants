import java.util.ArrayList;
import java.util.List;

class Solution {
    private static final int MOD = 1_000_000_007;
    private long[] fact;
    private long[] invFact;

    private void precomputeFactorials(int maxVal) {
        fact = new long[maxVal + 1];
        invFact = new long[maxVal + 1];
        fact[0] = 1;
        invFact[0] = 1;
        for (int i = 1; i <= maxVal; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }
        invFact[maxVal] = power(fact[maxVal], MOD - 2);
        for (int i = maxVal - 1; i >= 1; i--) {
            invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
        }
    }

    private long power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    private long nCr_mod_p(int n, int r) {
        if (r < 0 || r > n) {
            return 0;
        }
        // C(n, r) = C(n, n-r)
        // Here, r is exponent_a_j, which is small. So no need to optimize r = Math.min(r, n - r);
        return (((fact[n] * invFact[r]) % MOD) * invFact[n - r]) % MOD;
    }

    public int idealArrays(int n, int maxValue) {
        if (n == 1) {
            return maxValue;
        }

        // Max value for N in nCr(N, R) is exponent_a_j + (n-1) - 1 = exponent_a_j + n - 2.
        // Max exponent_a_j for maxValue=10^4 is 13 (2^13=8192).
        // Max n is 10^4. So max N = 13 + 10^4 - 2 = 10011.
        // Precompute factorials up to n + max_exponent_a_j - 1.
        precomputeFactorials(n + 13); 

        // Precompute smallest prime factor for each number up to maxValue
        int[] spf = new int[maxValue + 1];
        for (int i = 2; i <= maxValue; i++) {
            spf[i] = i;
        }
        for (int i = 2; i * i <= maxValue; i++) {
            if (spf[i] == i) { // i is prime
                for (int j = i * i; j <= maxValue; j += i) {
                    if (spf[j] == j) { // Only update if not already marked by a smaller prime
                        spf[j] = i;
                    }
                }
            }
        }

        // Precompute prime exponents for each number
        // exponents.get(i) stores a list of prime exponents for number i.
        // e.g., for 12 (2^2 * 3^1), exponents.get(12) = [2, 1]
        List<List<Integer>> exponents = new ArrayList<>(maxValue + 1);
        for (int i = 0; i <= maxValue; i++) {
            exponents.add(new ArrayList<>());
        }
        for (int i = 2; i <= maxValue; i++) {
            int num = i;
            while (num > 1) {
                int p = spf[num];
                int count = 0;
                while (num > 0 && num % p == 0) {
                    count++;
                    num /= p;
                }
                exponents.get(i).add(count);
            }
        }
        // For Y=1, exponents.get(1) is empty.
        // The loop for (int exponent_a_j : exponents.get(1)) will not run,
        // so waysForY remains 1. This correctly represents d_k(1)=1.

        long totalIdealArrays = 0;
        int k_factors = n - 1; // Number of factors x_i

        for (int arr0 = 1; arr0 <= maxValue; arr0++) {
            int limitY = maxValue / arr0;
            for (int Y = 1; Y <= limitY; Y++) {
                long waysForY = 1;
                for (int exponent_a_j : exponents.get(Y)) {
                    // This is C(exponent_a_j + k_factors - 1, k_factors - 1)
                    // which is C(exponent_a_j + k_factors - 1, exponent_a_j)
                    waysForY = (waysForY * nCr_mod_p(exponent_a_j + k_factors - 1, exponent_a_j)) % MOD;
                }
                totalIdealArrays = (totalIdealArrays + waysForY) % MOD;
            }
        }

        return (int) totalIdealArrays;
    }
}