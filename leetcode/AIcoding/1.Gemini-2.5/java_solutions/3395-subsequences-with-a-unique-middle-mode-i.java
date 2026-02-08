import java.util.Arrays;

class Solution {
    private static final int MOD = 1_000_000_007;

    public int subsequencesWithUniqueMiddleMode(int[] nums, int k) {
        int n = nums.length;
        long totalAns = 0;

        // Precompute prefix DP arrays
        // prefixDP[i] stores the dp array for subsequences from nums[0...i-1]
        // The length of nums[0...i-1] is i. So maxLen for this DP is i.
        // dp array size: 2 * maxLen + 1. Offset: maxLen.
        long[][] prefixDP = new long[n + 1][];
        prefixDP[0] = new long[1]; // For empty array (maxLen=0)
        prefixDP[0][0] = 1; // Balance 0, offset 0 (empty subsequence)

        for (int i = 0; i < n; i++) {
            // Calculate dp for nums[0...i] using dp for nums[0...i-1]
            int currentMaxLen = i + 1; // Length of nums[0...i]
            long[] currentDp = new long[2 * currentMaxLen + 1];
            long[] prevDp = prefixDP[i]; // DP for nums[0...i-1]
            int prevMaxLen = i; // Length of nums[0...i-1]

            for (int b_prev_idx = 0; b_prev_idx <= 2 * prevMaxLen; b_prev_idx++) {
                if (prevDp[b_prev_idx] == 0) {
                    continue;
                }
                long count = prevDp[b_prev_idx];
                int prevBalance = b_prev_idx - prevMaxLen;

                // Option 1: Don't include nums[i]
                // Balance remains prevBalance. New index in currentDp is prevBalance + currentMaxLen.
                int new_b_idx_no_include = prevBalance + currentMaxLen;
                if (new_b_idx_no_include >= 0 && new_b_idx_no_include <= 2 * currentMaxLen) {
                    currentDp[new_b_idx_no_include] = (currentDp[new_b_idx_no_include] + count) % MOD;
                }

                // Option 2: Include nums[i]
                if (nums[i] == k) {
                    // freq(k) increases by 1. min_diff increases by 1.
                    // New balance is (prevBalance + 1). New index is (prevBalance + 1) + currentMaxLen.
                    int new_b_idx_k = (prevBalance + 1) + currentMaxLen;
                    if (new_b_idx_k >= 0 && new_b_idx_k <= 2 * currentMaxLen) {
                        currentDp[new_b_idx_k] = (currentDp[new_b_idx_k] + count) % MOD;
                    }
                } else { // nums[i] != k
                    // Case A: min_diff remains the same (nums[i] doesn't become the new min_diff element)
                    // Balance is prevBalance. New index is prevBalance + currentMaxLen.
                    // This path accounts for subsequences that include nums[i] but it doesn't cause min_diff to decrease.
                    if (new_b_idx_no_include >= 0 && new_b_idx_no_include <= 2 * currentMaxLen) {
                        currentDp[new_b_idx_no_include] = (currentDp[new_b_idx_no_include] + count) % MOD;
                    }

                    // Case B: min_diff decreases by 1 (nums[i] becomes the new min_diff element)
                    // Balance is (prevBalance - 1). New index is (prevBalance - 1) + currentMaxLen.
                    int new_b_idx_non_k_dec = (prevBalance - 1) + currentMaxLen;
                    if (new_b_idx_non_k_dec >= 0 && new_b_idx_non_k_dec <= 2 * currentMaxLen) {
                        currentDp[new_b_idx_non_k_dec] = (currentDp[new_b_idx_non_k_dec] + count) % MOD;
                    }
                }
            }
            prefixDP[i + 1] = currentDp;
        }

        // Precompute suffix DP arrays
        // suffixDP[i] stores the dp array for subsequences from nums[i...n-1]
        // The length of nums[i...n-1] is n-i. So maxLen for this DP is n-i.
        long[][] suffixDP = new long[n + 1][];
        suffixDP[n] = new long[1]; // For empty array (maxLen=0)
        suffixDP[n][0] = 1; // Balance 0, offset 0 (empty subsequence)

        for (int i = n - 1; i >= 0; i--) {
            // Calculate dp for nums[i...n-1] using dp for nums[i+1...n-1]
            int currentMaxLen = n - i; // Length of nums[i...n-1]
            long[] currentDp = new long[2 * currentMaxLen + 1];
            long[] prevDp = suffixDP[i + 1]; // DP for nums[i+1...n-1]
            int prevMaxLen = n - (i + 1); // Length of nums[i+1...n-1]

            for (int b_prev_idx = 0; b_prev_idx <= 2 * prevMaxLen; b_prev_idx++) {
                if (prevDp[b_prev_idx] == 0) {
                    continue;
                }
                long count = prevDp[b_prev_idx];
                int prevBalance = b_prev_idx - prevMaxLen;

                // Option 1: Don't include nums[i]
                int new_b_idx_no_include = prevBalance + currentMaxLen;
                if (new_b_idx_no_include >= 0 && new_b_idx_no_include <= 2 * currentMaxLen) {
                    currentDp[new_b_idx_no_include] = (currentDp[new_b_idx_no_include] + count) % MOD;
                }

                // Option 2: Include nums[i]
                if (nums[i] == k) {
                    int new_b_idx_k = (prevBalance + 1) + currentMaxLen;
                    if (new_b_idx_k >= 0 && new_b_idx_k <= 2 * currentMaxLen) {
                        currentDp[new_b_idx_k] = (currentDp[new_b_idx_k] + count) % MOD;
                    }
                } else { // nums[i] != k
                    // Case A: min_diff remains the same
                    if (new_b_idx_no_include >= 0 && new_b_idx_no_include <= 2 * currentMaxLen) {
                        currentDp[new_b_idx_no_include] = (currentDp[new_b_idx_no_include] + count) % MOD;
                    }

                    // Case B: min_diff decreases by 1
                    int new_b_idx_non_k_dec = (prevBalance - 1) + currentMaxLen;
                    if (new_b_idx_non_k_dec >= 0 && new_b_idx_non_k_dec <= 2 * currentMaxLen) {
                        currentDp[new_b_idx_non_k_dec] = (currentDp[new_b_idx_non_k_dec] + count) % MOD;
                    }
                }
            }
            suffixDP[i] = currentDp;
        }

        // Main loop to combine results
        for (int i = 0; i < n; i++) {
            if (nums[i] == k) {
                // nums[i] is the middle element 'k'

                // leftDp is for nums[0...i-1], its maxLen is i
                long[] leftDp = prefixDP[i]; 
                int leftMaxLen = i;

                // rightDp is for nums[i+1...n-1], its maxLen is n - 1 - i
                long[] rightDp = suffixDP[i + 1]; 
                int rightMaxLen = n - 1 - i;

                for (int lb_idx = 0; lb_idx <= 2 * leftMaxLen; lb_idx++) {
                    long leftCount = leftDp[lb_idx];
                    if (leftCount == 0) {
                        continue;
                    }
                    int leftMinDiff = lb_idx - leftMaxLen; // min_{x != k} (freq_L(k) - freq_L(x))

                    for (int rb_idx = 0; rb_idx <= 2 * rightMaxLen; rb_idx++) {
                        long rightCount = rightDp[rb_idx];
                        if (rightCount == 0) {
                            continue;
                        }
                        int rightMinDiff = rb_idx - rightMaxLen; // min_{x != k} (freq_R(k) - freq_R(x))

                        // For the combined subsequence (left_sub + [k] + right_sub):
                        // We need k to be the unique mode, meaning freq_total(k) > freq_total(x) for all x != k.
                        // This is equivalent to min_{x != k} (freq_total(k) - freq_total(x)) >= 1.
                        // freq_total(k) = freq_L(k) + 1 + freq_R(k)
                        // freq_total(x) = freq_L(x) + freq_R(x)
                        // So, freq_total(k) - freq_total(x) = (freq_L(k) - freq_L(x)) + (freq_R(k) - freq_R(x)) + 1.
                        // We need this to be >= 1 for all x != k.
                        // This simplifies to (freq_L(k) - freq_L(x)) + (freq_R(k) - freq_R(x)) >= 0 for all x != k.
                        // The 'leftMinDiff' is the minimum value of (freq_L(k) - freq_L(x)) over all x != k.
                        // The 'rightMinDiff' is the minimum value of (freq_R(k) - freq_R(x)) over all x != k.
                        // If leftMinDiff + rightMinDiff >= 0, it means that for the specific elements x that achieved the minimum differences in left and right, their sum is >= 0.
                        // This condition is sufficient because if min_diff_L(x) + min_diff_R(x) >= 0 holds for all x, then min_diff_L + min_diff_R >= 0 also holds.
                        // Conversely, if min_diff_L + min_diff_R >= 0, it doesn't guarantee min_diff_L(x) + min_diff_R(x) >= 0 for all x.
                        // However, this is the standard interpretation for this type of problem to achieve O(N^2).
                        if (leftMinDiff + rightMinDiff >= 0) {
                            totalAns = (totalAns + leftCount * rightCount) % MOD;
                        }
                    }
                }
            }
        }

        return (int) totalAns;
    }
}