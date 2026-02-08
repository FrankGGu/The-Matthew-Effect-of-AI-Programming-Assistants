class Solution {
    private static final int MOD = 1_000_000_007;

    public int numberOfSequence(int n, int[] sick) {
        Arrays.sort(sick);
        long res = 1;
        int total = 0;
        for (int i = 0; i < sick.length; i++) {
            int prev = i == 0 ? -1 : sick[i - 1];
            int curr = sick[i];
            int diff = curr - prev - 1;
            if (diff > 0) {
                total += diff;
                res = res * comb(total, diff) % MOD;
                if (i > 0) {
                    res = res * pow(2, diff - 1) % MOD;
                }
            }
        }
        int lastDiff = n - sick[sick.length - 1] - 1;
        if (lastDiff > 0) {
            total += lastDiff;
            res = res * comb(total, lastDiff) % MOD;
        }
        return (int) res;
    }

    private long comb(int n, int k) {
        long res = 1;
        for (int i = 1; i <= k; i++) {
            res = res * (n - k + i) % MOD;
            res = res * inv(i) % MOD;
        }
        return res;
    }

    private long inv(int a) {
        return pow(a, MOD - 2);
    }

    private long pow(int a, int b) {
        long res = 1;
        long x = a;
        while (b > 0) {
            if (b % 2 == 1) {
                res = res * x % MOD;
            }
            x = x * x % MOD;
            b /= 2;
        }
        return res;
    }
}