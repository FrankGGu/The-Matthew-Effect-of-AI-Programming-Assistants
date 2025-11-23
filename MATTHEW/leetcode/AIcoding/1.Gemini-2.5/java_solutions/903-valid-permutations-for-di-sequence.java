class Solution {
    public int numPermsDISequence(String S) {
        int n = S.length();
        int MOD = 1_000_000_007;

        // dp[j] represents the number of valid permutations of length i+1 (using numbers 0 to i)
        // such that the last element P[i] has value j.
        // We use two arrays to optimize space: prev_dp for i-1 and dp for i.
        // prev_dp will hold the results for the previous length (i-1 elements, 0 to i-1 values).
        // dp will hold the results for the current length (i elements, 0 to i values).
        int[] prev_dp = new int[n + 1]; 

        // Base case: For i=0 (prefix of length 1, P[0]), it must be 0.
        // There is 1 way to form a permutation of [0] with P[0]=0.
        prev_dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            // dp for current i will have i+1 elements (P[i] can take values from 0 to i)
            int[] dp = new int[i + 1];

            // Calculate prefix and suffix sums for prev_dp.
            // prev_dp contains values for P[i-1] where P[i-1] ranges from 0 to i-1.
            // So, prefix_sums and suffix_sums arrays will be of size 'i'.
            int[] prefix_sums = new int[i];
            int[] suffix_sums = new int[i];

            // Fill prefix_sums for prev_dp
            prefix_sums[0] = prev_dp[0];
            for (int k_prev = 1; k_prev < i; k_prev++) {
                prefix_sums[k_prev] = (prefix_sums[k_prev - 1] + prev_dp[k_prev]) % MOD;
            }

            // Fill suffix_sums for prev_dp
            suffix_sums[i - 1] = prev_dp[i - 1];
            for (int k_prev = i - 2; k_prev >= 0; k_prev--) {
                suffix_sums[k_prev] = (suffix_sums[k_prev + 1] + prev_dp[k_prev]) % MOD;
            }

            char relation = S.charAt(i - 1); // Get the relation for P[i-1] and P[i]

            for (int j = 0; j <= i; j++) { // j is the value of P[i]
                if (relation == 'I') { // P[i-1] < P[i]
                    // P[i] takes value j. P[i-1] must take a value k_actual < j.
                    // The values in prev_dp[k_prev] refer to P[i-1] taking value k_prev among {0, ..., i-1}.
                    // When we introduce 'j' into the set {0, ..., i-1} to form {0, ..., i}:
                    // - If k_prev < j, its value remains k_prev. This satisfies k_prev < j.
                    // - If k_prev >= j, its value becomes k_prev + 1. This would mean k_prev + 1 < j, which is impossible.
                    // So, we sum prev_dp[k_prev] for k_prev from 0 to j-1.
                    dp[j] = (j == 0) ? 0 : prefix_sums[j - 1];
                } else { // relation == 'D', P[i-1] > P[i]
                    // P[i] takes value j. P[i-1] must take a value k_actual > j.
                    // - If k_prev < j, its value remains k_prev. This would mean k_prev > j, which is impossible.
                    // - If k_prev >= j, its value becomes k_prev + 1. This satisfies k_prev + 1 > j.
                    // So, we sum prev_dp[k_prev] for k_prev from j to i-1.
                    dp[j] = (j == i) ? 0 : suffix_sums[j];
                }
            }
            prev_dp = dp; // The current dp becomes the previous dp for the next iteration
        }

        // The final answer is the sum of all possibilities for the last row (dp for i=n)
        int total_permutations = 0;
        for (int j = 0; j <= n; j++) {
            total_permutations = (total_permutations + prev_dp[j]) % MOD;
        }

        return total_permutations;
    }
}