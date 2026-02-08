#include <string.h> // For memset
#include <math.h>   // For fmax

#define MAX_VAL 200
#define MAX_XOR_SUM 255

int maximumLength(int* nums, int n) {
    // dp[last_val][xor_sum] stores the maximum length of a good subsequence
    // that ends with 'last_val' and has an XOR sum of 'xor_sum'.
    // The dimensions are (MAX_VAL + 1) for values 0 to 200,
    // and (MAX_XOR_SUM + 1) for XOR sums 0 to 255.
    int dp[MAX_VAL + 1][MAX_XOR_SUM + 1];

    // Initialize the dp table with 0s.
    // A value of 0 indicates that no such subsequence has been found yet.
    memset(dp, 0, sizeof(dp));

    int max_overall_len = 0;

    // Iterate through each number in the input array.
    for (int i = 0; i < n; i++) {
        int current_num = nums[i];

        // Iterate over all possible previous ending values (prev_val).
        // For a strictly increasing subsequence, prev_val must be less than current_num.
        for (int prev_val = 0; prev_val < current_num; prev_val++) {
            // Iterate over all possible previous XOR sums (prev_xor_sum).
            for (int prev_xor_sum = 0; prev_xor_sum <= MAX_XOR_SUM; prev_xor_sum++) {
                // If a valid subsequence ending with prev_val and having prev_xor_sum exists (length > 0).
                if (dp[prev_val][prev_xor_sum] > 0) {
                    // Calculate the new XOR sum by including current_num.
                    int new_xor_sum = prev_xor_sum ^ current_num;

                    // Update the maximum length for a subsequence ending with current_num
                    // and having new_xor_sum.
                    // We take the maximum between the current recorded length and
                    // the length of the extended subsequence (dp[prev_val][prev_xor_sum] + 1).
                    dp[current_num][new_xor_sum] = fmax(dp[current_num][new_xor_sum], dp[prev_val][prev_xor_sum] + 1);
                }
            }
        }

        // Also consider current_num itself as a subsequence of length 1.
        // This serves as a base case for forming new subsequences.
        // Its XOR sum is simply current_num.
        dp[current_num][current_num] = fmax(dp[current_num][current_num], 1);
    }

    // After processing all numbers, the answer is the maximum length among all
    // subsequences that have an XOR sum of 0.
    for (int val = 0; val <= MAX_VAL; val++) {
        max_overall_len = fmax(max_overall_len, dp[val][0]);
    }

    return max_overall_len;
}