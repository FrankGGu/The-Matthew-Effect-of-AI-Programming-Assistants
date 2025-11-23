public class Solution {

import java.util.*;

public class Solution {
    public int idealArrays(int n, int[] queries) {
        int MOD = 1000000007;
        Map<Integer, Integer> primeCount = new HashMap<>();
        for (int num : queries) {
            if (num == 1) continue;
            Map<Integer, Integer> factors = getPrimeFactors(num);
            for (Map.Entry<Integer, Integer> entry : factors.entrySet()) {
                primeCount.put(entry.getKey(), primeCount.getOrDefault(entry.getKey(), 0) + entry.getValue());
            }
        }

        long result = 1;
        for (Map.Entry<Integer, Integer> entry : primeCount.entrySet()) {
            int k = entry.getValue();
            int m = n;
            long c = comb(m, k, MOD);
            result = (result * c) % MOD;
        }

        return (int) result;
    }

    private Map<Integer, Integer> getPrimeFactors(int num) {
        Map<Integer, Integer> factors = new HashMap<>();
        for (int i = 2; i * i <= num; i++) {
            while (num % i == 0) {
                factors.put(i, factors.getOrDefault(i, 0) + 1);
                num /= i;
            }
        }
        if (num > 1) {
            factors.put(num, factors.getOrDefault(num, 0) + 1);
        }
        return factors;
    }

    private long comb(int n, int k, int mod) {
        long[][] dp = new long[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            dp[i][0] = 1;
        }
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= Math.min(i, k); j++) {
                dp[i][j] = (dp[i - 1][j - 1] + dp[i - 1][j]) % mod;
            }
        }
        return dp[n][k];
    }
}
}