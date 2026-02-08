import java.util.*;

class Solution {
    private static final int MOD = 1_000_000_007;
    private static final int MAX_N = 10000;
    private static final int MAX_K = 13; // log2(10000) ~ 13.29
    private static List<Integer> primes;
    private static int[][] comb;
    private static int[] inv;

    static {
        sieve();
        precomputeCombinations();
        precomputeInverses();
    }

    private static void sieve() {
        boolean[] isPrime = new boolean[MAX_N + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= MAX_N; i++) {
            if (isPrime[i]) {
                for (int j = i * i; j <= MAX_N; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        primes = new ArrayList<>();
        for (int i = 2; i <= MAX_N; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }
    }

    private static void precomputeCombinations() {
        comb = new int[MAX_N + MAX_K][MAX_K + 1];
        comb[0][0] = 1;
        for (int n = 1; n < comb.length; n++) {
            comb[n][0] = 1;
            for (int k = 1; k <= Math.min(n, MAX_K); k++) {
                comb[n][k] = (comb[n - 1][k - 1] + comb[n - 1][k]) % MOD;
            }
        }
    }

    private static void precomputeInverses() {
        inv = new int[MAX_K + 2];
        inv[1] = 1;
        for (int i = 2; i <= MAX_K + 1; i++) {
            inv[i] = (int) ((MOD - (long) MOD / i) * inv[MOD % i] % MOD);
        }
    }

    public int[] waysToFillArray(int[][] queries) {
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int n = queries[i][0];
            int k = queries[i][1];
            result[i] = solve(n, k);
        }
        return result;
    }

    private int solve(int n, int k) {
        if (k == 1) return 1;
        long res = 1;
        for (int p : primes) {
            if (p * p > k) break;
            if (k % p != 0) continue;
            int cnt = 0;
            while (k % p == 0) {
                k /= p;
                cnt++;
            }
            res = res * comb[n + cnt - 1][cnt] % MOD;
        }
        if (k > 1) {
            res = res * n % MOD;
        }
        return (int) res;
    }
}