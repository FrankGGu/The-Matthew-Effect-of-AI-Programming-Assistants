#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007
#define MAX_N 101 // N <= 100

long long combinations[MAX_N][MAX_N];

void precompute_combinations() {
    for (int i = 0; i < MAX_N; i++) {
        combinations[i][0] = 1;
        for (int j = 1; j <= i; j++) {
            combinations[i][j] = (combinations[i - 1][j - 1] + combinations[i - 1][j]) % MOD;
        }
    }
}

long long*** solve_part(int* arr, int arr_len, int target_val, int max_len_to_pick) {
    long long*** dp = (long long***)calloc(max_len_to_pick + 1, sizeof(long long**));
    for (int k_picked = 0; k_picked <= max_len_to_pick; k_picked++) {
        dp[k_picked] = (long long**)calloc(k_picked + 1, sizeof(long long*));
        for (int f_v = 0; f_v <= k_picked; f_v++) {
            dp[k_picked][f_v] = (long long*)calloc(k_picked + 1, sizeof(long long));
        }
    }

    dp[0][0][0] = 1;

    // Use a map to count frequencies of distinct elements in the current `arr`
    // This is to correctly use combinations[count_d][c_d]
    // and to iterate through distinct elements only once.
    // Since nums[i] can be large, we can't use them as direct indices.
    // A simple approach is to iterate through the array directly,
    // but that would make max_freq_other update tricky.
    // The correct way for this DP state is to iterate through distinct elements.

    // Step 1: Count frequencies of distinct elements in `arr`
    typedef struct {
        int val;
        int count;
    } DistinctElement;

    DistinctElement* distinct_elements = (DistinctElement*)calloc(arr_len, sizeof(DistinctElement));
    int distinct_count = 0;

    // A temporary map to count frequencies in `arr`
    // For C, we can simulate with qsort and unique or a hash map.
    // Given N <= 100, a simple linear scan for distinct elements is fine.
    // Or, for simplicity, use a temporary array and sort it to find distinct elements.
    int* temp_arr_sorted = (int*)malloc(arr_len * sizeof(int));
    memcpy(temp_arr_sorted, arr, arr_len * sizeof(int));

    // Sort temp_arr_sorted to easily find distinct elements and their counts
    // qsort takes a comparison function
    qsort(temp_arr_sorted, arr_len, sizeof(int), (int (*)(const void *, const void *))strcmp); // Using strcmp for int comparison is wrong.
                                                                                                // Need a proper int comparison function.

    // Correct qsort comparison function for integers
    int compare_ints(const void *a, const void *b) {
        return (*(int*)a - *(int*)b);
    }
    qsort(temp_arr_sorted, arr_len, sizeof(int), compare_ints);

    if (arr_len > 0) {
        distinct_elements[distinct_count].val = temp_arr_sorted[0];
        distinct_elements[distinct_count].count = 1;
        for (int i = 1; i < arr_len; i++) {
            if (temp_arr_sorted[i] == distinct_elements[distinct_count].val) {
                distinct_elements[distinct_count].count++;
            } else {
                distinct_count++;
                distinct_elements[distinct_count].val = temp_arr_sorted[i];
                distinct_elements[distinct_count].count = 1;
            }
        }
        distinct_count++;
    }
    free(temp_arr_sorted);

    // Iterate through each distinct element in `arr`
    for (int i = 0; i < distinct_count; i++) {
        int val_d = distinct_elements[i].val;
        int count_d = distinct_elements[i].count;

        long long*** new_dp = (long long***)calloc(max_len_to_pick + 1, sizeof(long long**));
        for (int k_picked = 0; k_picked <= max_len_to_pick; k_picked++) {
            new_dp[k_picked] = (long long**)calloc(k_picked + 1, sizeof(long long*));
            for (int f_v = 0; f_v <= k_picked; f_v++) {
                new_dp[k_picked][f_v] = (long long*)calloc(k_picked + 1, sizeof(long long));
            }
        }

        for (int k_p = 0; k_p <= max_len_to_pick; k_p++) {
            for (int f_v = 0; f_v <= k_p; f_v++) {
                for (int f_o = 0; f_o <= k_p; f_o++) {
                    if (dp[k_p][f_v][f_o] == 0) continue;

                    // Option 1: Don't pick any instance of val_d
                    new_dp[k_p][f_v][f_o] = (new_dp[k_p][f_v][f_o] + dp[k_p][f_v][f_o]) % MOD;

                    // Option 2: Pick c_d instances of val_d
                    if (val_d == target_val) {
                        for (int c_d = 1; c_d <= count_d; c_d++) {
                            if (k_p + c_d <= max_len_to_pick && f_v + c_d <= max_len_to_pick) {
                                long long ways = (dp[k_p][f_v][f_o] * combinations[count_d][c_d]) % MOD;
                                new_dp[k_p + c_d][f_v + c_d][f_o] = (new_dp[k_p + c_d][f_v + c_d][f_o] + ways) % MOD;
                            }
                        }
                    } else { // val_d != target_val
                        for (int c_d = 1; c_d <= count_d; c_d++) {
                            if (k_p + c_d <= max_len_to_pick) {
                                long long ways = (dp[k_p][f_v][f_o] * combinations[count_d][c_d]) % MOD;
                                int new_f_o = (f_o > c_d) ? f_o : c_d; // Max of current max_freq_other and freq of val_d
                                new_dp[k_p + c_d][f_v][new_f_o] = (new_dp[k_p + c_d][f_v][new_f_o] + ways) % MOD;
                            }
                        }
                    }
                }
            }
        }
        // Free old dp and update to new_dp
        for (int k_picked = 0; k_picked <= max_len_to_pick; k_picked++) {
            for (int f_v = 0; f_v <= k_picked; f_v++) {
                free(dp[k_picked][f_v]);
            }
            free(dp[k_picked]);
        }
        free(dp);
        dp = new_dp;
    }

    free(distinct_elements);
    return dp;
}

void free_dp(long long*** dp, int max_len_to_pick) {
    if (!dp) return;
    for (int k_picked = 0; k_picked <= max_len_to_pick; k_picked++) {
        if (!dp[k_picked]) continue;
        for (int f_v = 0; f_v <= k_picked; f_v++) {
            free(dp[k_picked][f_v]);
        }
        free(dp[k_picked]);
    }
    free(dp);
}

long long countSubsequencesWithUniqueMiddleMode(int* nums, int n) {
    precompute_combinations();

    long long total_valid_subsequences = 0;

    for (int i = 0; i < n; i++) { // Iterate through each possible middle element nums[i]
        int middle_val = nums[i];

        // Prepare left and right subarrays
        int* left_arr = (int*)malloc(i * sizeof(int));
        memcpy(left_arr, nums, i * sizeof(int));

        int right_arr_len = n - 1 - i;
        int* right_arr = (int*)malloc(right_arr_len * sizeof(int));
        memcpy(right_arr, nums + i + 1, right_arr_len * sizeof(int));

        // Calculate DP tables for left and right parts
        // max_len_to_pick for left is `i`, for right is `n-1-i`.
        // The maximum length for k_picked is N/2, but for DP state it can go up to `i` or `n-1-i`.
        // However, the actual `k` for a subsequence is `k_l` and `k_r`, which must be equal.
        // So max_len_to_pick can be bounded by n/2.
        int max_k_on_side = (n - 1) / 2;

        long long*** dp_left = solve_part(left_arr, i, middle_val, max_k_on_side);
        long long*** dp_right = solve_part(right_arr, right_arr_len, middle_val, max_k_on_side);

        // Combine results from left and right DP tables
        for (int k_l = 0; k_l <= max_k_on_side; k_l++) { // Number of elements picked from left side
            for (int f_v_l = 0; f_v_l <= k_l; f_v_l++) { // Frequency of middle_val in left part
                for (int f_o_l = 0; f_o_l <= k_l; f_o_l++) { // Max frequency of other elements in left part
                    if (dp_left[k_l][f_v_l][f_o_l] == 0) continue;

                    for (int k_r = 0; k_r <= max_k_on_side; k_r++) { // Number of elements picked from right side
                        if (k_l != k_r) continue; // Subsequence must have odd length, so k_l == k_r

                        for (int f_v_r = 0; f_v_r <= k_r; f_v_r++) { // Frequency of middle_val in right part
                            for (int f_o_r = 0; f_o_r <= k_r; f_o_r++) { // Max frequency of other elements in right part
                                if (dp_right[k_r][f_v_r][f_o_r] == 0) continue;

                                int total_freq_middle_val = 1 + f_v_l + f_v_r;
                                int max_freq_other_elements = (f_o_l > f_o_r) ? f_o_l : f_o_r;

                                if (total_freq_middle_val > max_freq_other_elements) {
                                    long long ways = (dp_left[k_l][f_v_l][f_o_l] * dp_right[k_r][f_v_r][f_o_r]) % MOD;
                                    total_valid_subsequences = (total_valid_subsequences + ways) % MOD;
                                }
                            }
                        }
                    }
                }
            }
        }

        free(left_arr);
        free(right_arr);
        free_dp(dp_left, max_k_on_side);
        free_dp(dp_right, max_k_on_side);
    }

    return total_valid_subsequences;
}