#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maximizeWin(int* nums, int numsSize, int k) {
    if (numsSize == 0) {
        return 0;
    }

    // 1. Precompute prefix sums
    long long* prefix_sum = (long long*)calloc(numsSize + 1, sizeof(long long));
    for (int i = 0; i < numsSize; ++i) {
        prefix_sum[i + 1] = prefix_sum[i] + nums[i];
    }

    // 2. Precompute has_valid[s][e]
    // has_valid[s][e] is true if sum(nums[s..e]) <= k
    int** has_valid = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; ++i) {
        has_valid[i] = (int*)calloc(numsSize, sizeof(int));
    }

    for (int s = 0; s < numsSize; ++s) {
        for (int e = s; e < numsSize; ++e) {
            if (prefix_sum[e + 1] - prefix_sum[s] <= k) {
                has_valid[s][e] = 1;
            }
        }
    }

    // 3. Precompute dp_prefix[i]
    // dp_prefix[i] = max count of disjoint valid subarrays ending at or before index i.
    int* dp_prefix = (int*)calloc(numsSize, sizeof(int));
    // To optimize dp_prefix calculation, group valid subarrays by end index
    int** ends_at = (int**)malloc(numsSize * sizeof(int*));
    int* ends_at_counts = (int*)calloc(numsSize, sizeof(int));
    for (int i = 0; i < numsSize; ++i) {
        ends_at[i] = (int*)malloc(numsSize * sizeof(int)); // Max numsSize starts for any end
    }
    for (int s = 0; s < numsSize; ++s) {
        for (int e = s; e < numsSize; ++e) {
            if (has_valid[s][e]) {
                ends_at[e][ends_at_counts[e]++] = s;
            }
        }
    }

    dp_prefix[0] = has_valid[0][0]; // If (0,0) is valid, count 1, else 0.
    for (int i = 0; i < numsSize; ++i) {
        if (i > 0) {
            dp_prefix[i] = dp_prefix[i - 1];
        }
        for (int j = 0; j < ends_at_counts[i]; ++j) {
            int s = ends_at[i][j];
            dp_prefix[i] = max(dp_prefix[i], (s > 0 ? dp_prefix[s - 1] : 0) + 1);
        }
    }

    // 4. Precompute dp_suffix[i]
    // dp_suffix[i] = max count of disjoint valid subarrays starting at or after index i.
    int* dp_suffix = (int*)calloc(numsSize, sizeof(int));
    // To optimize dp_suffix calculation, group valid subarrays by start index
    int** starts_at = (int**)malloc(numsSize * sizeof(int*));
    int* starts_at_counts = (int*)calloc(numsSize, sizeof(int));
    for (int i = 0; i < numsSize; ++i) {
        starts_at[i] = (int*)malloc(numsSize * sizeof(int)); // Max numsSize ends for any start
    }
    for (int s = 0; s < numsSize; ++s) {
        for (int e = s; e < numsSize; ++e) {
            if (has_valid[s][e]) {
                starts_at[s][starts_at_counts[s]++] = e;
            }
        }
    }

    dp_suffix[numsSize - 1] = has_valid[numsSize - 1][numsSize - 1]; // If (N-1, N-1) is valid, count 1, else 0.
    for (int i = numsSize - 1; i >= 0; --i) {
        if (i < numsSize - 1) {
            dp_suffix[i] = dp_suffix[i + 1];
        }
        for (int j = 0; j < starts_at_counts[i]; ++j) {
            int e = starts_at[i][j];
            dp_suffix[i] = max(dp_suffix[i], (e < numsSize - 1 ? dp_suffix[e + 1] : 0) + 1);
        }
    }

    // 5. Precompute min_s_for_e[e]
    // min_s_for_e[e] = minimum s such that (s, e) is a valid subarray. Initialize with numsSize (infinity).
    int* min_s_for_e = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; ++i) {
        min_s_for_e[i] = numsSize;
    }
    for (int e = 0; e < numsSize; ++e) {
        for (int s = 0; s <= e; ++s) {
            if (has_valid[s][e]) {
                min_s_for_e[e] = min(min_s_for_e[e], s);
            }
        }
    }

    // 6. Precompute max_suffix_query[e2_start][s_max]
    // max_suffix_query[e2_start][s_max] = max_{e2 in [e2_start, numsSize-1], min_s_for_e[e2] <= s_max} (dp_suffix[e2+1])
    int** max_suffix_query = (int**)malloc((numsSize + 1) * sizeof(int*));
    for (int i = 0; i <= numsSize; ++i) {
        max_suffix_query[i] = (int*)calloc(numsSize + 1, sizeof(int)); // s_max up to numsSize-1
    }

    for (int e2_start = numsSize - 1; e2_start >= 0; --e2_start) {
        for (int s_max = 0; s_max < numsSize; ++s_max) {
            // Option 1: Don't include e2_start, take value from next e2_start
            int val_from_next_e2_start = max_suffix_query[e2_start + 1][s_max];

            // Option 2: Don't consider current s_max, take value from previous s_max
            int val_from_prev_s_max = (s_max > 0 ? max_suffix_query[e2_start][s_max - 1] : 0);

            // Option 3: Include e2_start if condition met
            int current_e2_val = 0;
            if (min_s_for_e[e2_start] <= s_max) {
                current_e2_val = (e2_start < numsSize - 1 ? dp_suffix[e2_start + 1] : 0);
            }

            max_suffix_query[e2_start][s_max] = max(val_from_next_e2_start, max(val_from_prev_s_max, current_e2_val));
        }
    }

    // 7. Calculate final answer
    int ans = (numsSize > 0 ? dp_prefix[numsSize - 1] : 0);

    for (int s1 = 0; s1 < numsSize; ++s1) {
        for (int e1 = s1; e1 < numsSize; ++e1) {
            if (has_valid[s1][e1]) {
                int current_prefix_count = (s1 > 0 ? dp_prefix[s1 - 1] : 0);
                int max_suffix_contribution = 0;

                // Case B: e2 > e1 (or e2 = e1 with s2 <= e1)
                // Query max_suffix_query[s1][e1] for e2 in [s1, N-1] and min_s_for_e[e2] <= e1.
                // This covers e2 >= s1 and s2 <= e1.
                max_suffix_contribution = max(max_suffix_contribution, max_suffix_query[s1][e1]);

                // Case A: e2 < e1, but still overlaps (s1 <= e2 < e1 and s2 <= e1)
                // Here, max(e1, e2) = e1. We need to check if there exists any S2=(s2, e2)
                // such that s2 <= e1 AND e2 >= s1 AND e2 < e1.
                // This means we need to find if there's a valid (s2, e2) with s2 <= e1 and e2 in [s1, e1-1].
                // We can use the precomputed min_s_for_e.
                // Check if any e2 in [s1, e1-1] has min_s_for_e[e2] <= e1.
                int exists_overlap_case_A = 0;
                for (int e2_check = s1; e2_check < e1; ++e2_check) {
                    if (min_s_for_e[e2_check] <= e1) {
                        exists_overlap_case_A = 1;
                        break;
                    }
                }
                if (exists_overlap_case_A) {
                    max_suffix_contribution = max(max_suffix_contribution, (e1 < numsSize - 1 ? dp_suffix[e1 + 1] : 0));
                }

                ans = max(ans, current_prefix_count + 2 + max_suffix_contribution);
            }
        }
    }

    // Free allocated memory
    free(prefix_sum);
    for (int i = 0; i < numsSize; ++i) {
        free(has_valid[i]);
    }
    free(has_valid);
    free(dp_prefix);
    for (int i = 0; i < numsSize; ++i) {
        free(ends_at[i]);
    }
    free(ends_at);
    free(ends_at_counts);
    free(dp_suffix);
    for (int i = 0; i < numsSize; ++i) {
        free(starts_at[i]);
    }
    free(starts_at);
    free(starts_at_counts);
    free(min_s_for_e);
    for (int i = 0; i <= numsSize; ++i) {
        free(max_suffix_query[i]);
    }
    free(max_suffix_query);

    return ans;
}