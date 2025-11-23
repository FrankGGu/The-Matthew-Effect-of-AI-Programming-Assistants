import java.util.Arrays;

class Solution {
    private static final int MOD = 1_000_000_007;

    private long[] fact;
    private long[] invFact;
    private long[] pow2;

    private void precomputeFactorials(int n) {
        fact = new long[n + 1];
        invFact = new long[n + 1];
        fact[0] = 1;
        invFact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
            invFact[i] = power(fact[i], MOD - 2);
        }
    }

    private void precomputePowersOf2(int n) {
        pow2 = new long[n + 1];
        pow2[0] = 1;
        for (int i = 1; i <= n; i++) {
            pow2[i] = (pow2[i - 1] * 2) % MOD;
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

    private long nCr(int n, int r) {
        if (r < 0 || r > n) {
            return 0;
        }
        return (((fact[n] * invFact[r]) % MOD) * invFact[n - r]) % MOD;
    }

    public int sumsOfSubsequences(int[] nums, int k) {
        int n = nums.length;
        Arrays.sort(nums);

        precomputeFactorials(n);
        precomputePowersOf2(n);

        long[] dpWays = new long[n]; // dpWays[x] = sum_{p=0}^{min(x, k-2)} C(x, p)
        int M = k - 2;

        if (M < 0) { // k = 1, no elements can be chosen from middle
            Arrays.fill(dpWays, 0);
        } else {
            dpWays[0] = 1; // C(0,0)
            for (int x = 1; x < n; x++) {
                if (x <= M) {
                    dpWays[x] = pow2[x];
                } else { // x > M
                    // dpWays[x] = sum_{p=0}^{M} C(x, p)
                    // dpWays[x-1] = sum_{p=0}^{M} C(x-1, p)
                    // C(x,p) = C(x-1,p) + C(x-1,p-1)
                    // dpWays[x] = sum_{p=0}^{M} (C(x-1,p) + C(x-1,p-1))
                    //           = dpWays[x-1] + sum_{p=0}^{M} C(x-1,p-1)
                    //           = dpWays[x-1] + sum_{p'=-1}^{M-1} C(x-1,p')
                    //           = dpWays[x-1] + sum_{p'=0}^{M-1} C(x-1,p')
                    //           = dpWays[x-1] + (dpWays[x-1] - C(x-1, M))
                    dpWays[x] = (2 * dpWays[x - 1] - nCr(x - 1, M) + MOD) % MOD;
                }
            }
        }

        long[] prefixSum_dpWays = new long[n];
        if (n > 0) {
            prefixSum_dpWays[0] = dpWays[0];
            for (int x = 1; x < n; x++) {
                prefixSum_dpWays[x] = (prefixSum_dpWays[x - 1] + dpWays[x]) % MOD;
            }
        }

        long totalSum = 0;

        for (int i = 0; i < n; i++) {
            // Contribution of nums[i] as min_val
            // It's paired with nums[j] where j >= i.
            // For j=i, ways = 1 (subsequence [nums[i]])
            // For j > i, ways = dpWays[j-i-1]. Sum is sum_{p=0}^{n-i-2} dpWays[p].
            long waysAsMin = 1;
            if (i < n - 1) { // if there are elements to the right
                waysAsMin = (waysAsMin + prefixSum_dpWays[n - i - 2]) % MOD;
            }
            totalSum = (totalSum + (long)nums[i] * waysAsMin) % MOD;

            // Contribution of nums[i] as max_val
            // It's paired with nums[j] where j <= i.
            // For j=i, ways = 1 (subsequence [nums[i]])
            // For j < i, ways = dpWays[i-j-1]. Sum is sum_{p=0}^{i-1} dpWays[p].
            long waysAsMax = 1;
            if (i > 0) { // if there are elements to the left
                waysAsMax = (waysAsMax + prefixSum_dpWays[i - 1]) % MOD;
            }
            totalSum = (totalSum + (long)nums[i] * waysAsMax) % MOD;
        }

        return (int) totalSum;
    }
}