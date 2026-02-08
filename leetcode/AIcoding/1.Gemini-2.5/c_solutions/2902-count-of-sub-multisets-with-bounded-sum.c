#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

#define MOD 1000000007

int countSubMultisets(int* nums, int numsSize, int l, int r) {
    // Determine the maximum possible sum we might need to track.
    // The maximum sum of all elements in nums is numsSize * max_num_value.
    // numsSize <= 1000, nums[i] <= 1000, so max_possible_sum = 1000 * 1000 = 1,000,000.
    // We only need to compute DP up to 'r'.
    int max_sum = r;

    // Count frequencies of each number in nums.
    // Numbers are between 0 and 1000.
    int freq[1001] = {0};
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    // dp[s] will store the number of sub-multisets with sum s.
    // Initialize dp[0] = 1 for the empty multiset.
    long long* dp = (long long*)calloc(max_sum + 1, sizeof(long long));
    if (dp == NULL) {
        // Handle allocation error
        return 0;
    }
    dp[0] = 1;

    // Allocate a temporary queue 'q' once to be reused for sliding window optimization.
    // Its maximum size is when num=1, which is max_sum + 1.
    long long* q = (long long*)malloc((max_sum + 1) * sizeof(long long));
    if (q == NULL) {
        free(dp);
        return 0;
    }

    // Iterate through each unique number from 1 to 1000.
    // Number 0 is handled separately at the end.
    for (int num = 1; num <= 1000; num++) {
        if (freq[num] == 0) {
            continue; // Skip if this number is not in nums
        }

        int count = freq[num]; // The maximum number of times 'num' can be used

        // Apply sliding window DP for bounded knapsack.
        // For each remainder 'rem' when dividing by 'num', process sums in that arithmetic progression.
        // This optimizes the update from O(count) to O(1) for each sum.
        for (int rem = 0; rem < num; rem++) {
            long long current_window_sum = 0;
            int head = 0; // Head of the sliding window in 'q'
            int tail = 0; // Tail of the sliding window in 'q'

            // Iterate through sums of the form `rem + k_idx * num`
            // `k_idx` represents the multiplier for `num`.
            int max_k_idx = (max_sum - rem) / num; // Max k_idx for current remainder chain

            for (int k_idx = 0; k_idx <= max_k_idx; k_idx++) {
                int current_s = rem + k_idx * num;

                // Add the old dp[current_s] value to the window sum.
                // Store it in 'q' for potential future removal.
                q[tail] = dp[current_s];
                current_window_sum = (current_window_sum + q[tail]) % MOD;
                tail++;

                // If the window size (number of terms) exceeds (count + 1),
                // remove the oldest element from the window sum.
                // The window should contain dp_old[current_s], dp_old[current_s - num], ..., dp_old[current_s - count*num].
                // This means there are 'count + 1' terms.
                // If k_idx > count, it means we have more than 'count + 1' terms in the conceptual window.
                // The term to remove is `dp_old[current_s - (count + 1)*num]`, which corresponds to `q[head]`.
                if (k_idx > count) {
                    current_window_sum = (current_window_sum - q[head] + MOD) % MOD;
                    head++;
                }

                // Update dp[current_s] with the sum of the current window.
                // This sum represents the number of ways to form 'current_s' using 'num' up to 'count' times,
                // combined with numbers processed previously.
                dp[current_s] = current_window_sum;
            }
        }
    }

    // Handle the number 0.
    // If 0 is present in nums (freq[0] > 0), any multiset with sum 's' can be combined
    // with 0, 1, ..., freq[0] occurrences of 0.
    // This means the number of ways to form 's' is multiplied by (freq[0] + 1).
    // This applies to all sums, including sum 0 itself (which has (freq[0] + 1) ways to be formed by only zeros).
    if (freq[0] > 0) {
        long long factor = freq[0] + 1;
        for (int s = 0; s <= max_sum; s++) {
            dp[s] = (dp[s] * factor) % MOD;
        }
    }

    // Sum up the counts for all sums s such that l <= s <= r.
    long long total_count = 0;
    for (int s = l; s <= r; s++) {
        total_count = (total_count + dp[s]) % MOD;
    }

    // Free allocated memory
    free(dp);
    free(q);

    return (int)total_count;
}