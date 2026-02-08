import java.util.Arrays;

class Solution {
    private static final int MOD = 1_000_000_007;

    public int sumOfPowers(int[] nums, int k, int p) {
        Arrays.sort(nums);
        int n = nums.length;

        // dp[i][j][min_idx] stores the count of subsequences of length j
        // where nums[i] is the maximum element and nums[min_idx] is the minimum element.
        long[][][] dp = new long[n][k + 1][n];

        for (int i = 0; i < n; i++) {
            // Base case: subsequence of length 1
            // nums[i] is both the min and max element.
            dp[i][1][i] = 1;

            for (int j = 2; j <= k; j++) {
                // min_idx must be less than i if j > 1, because nums[i] is the maximum
                // and nums[min_idx] is the minimum. If min_idx == i, then j must be 1.
                for (int min_idx = 0; min_idx < i; min_idx++) {
                    // To form a subsequence of length j ending at nums[i] (as max)
                    // with nums[min_idx] as min:
                    // We need to pick j-1 elements before nums[i], such that
                    // nums[min_idx] is their minimum, and nums[p] is their maximum (where min_idx <= p < i).
                    for (int prev_max_idx = min_idx; prev_max_idx < i; prev_max_idx++) {
                        dp[i][j][min_idx] = (dp[i][j][min_idx] + dp[prev_max_idx][j - 1][min_idx]) % MOD;
                    }
                }
            }
        }

        long totalSum = 0;
        for (int i = 0; i < n; i++) { // i is the index of the maximum element
            for (int min_idx = 0; min_idx <= i; min_idx++) { // min_idx is the index of the minimum element
                if (dp[i][k][min_idx] > 0) {
                    long diff = nums[i] - nums[min_idx];
                    long powerVal = power(diff, p);
                    totalSum = (totalSum + dp[i][k][min_idx] * powerVal) % MOD;
                }
            }
        }

        return (int) totalSum;
    }

    // Modular exponentiation (base^exp % MOD)
    private long power(long base, int exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) { // If exp is odd
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD; // Square the base
            exp /= 2; // Halve the exponent
        }
        return res;
    }
}