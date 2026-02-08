#include <stdlib.h> // For malloc and free

long long numberOfWays(int* nums, int numsSize) {
    int n = numsSize;
    if (n < 3) {
        return 0;
    }

    long long total_sum = 0;
    for (int k = 0; k < n; k++) {
        total_sum += nums[k];
    }

    long long* prefix_sum = (long long*)malloc(n * sizeof(long long));
    prefix_sum[0] = nums[0];
    for (int k = 1; k < n; k++) {
        prefix_sum[k] = prefix_sum[k-1] + nums[k];
    }

    long long count = 0;
    int j_min_ptr = 1; // Pointer for the lower bound of 'j'
    int j_max_ptr = 1; // Pointer for the upper bound of 'j'

    // 'i' is the index of the last element of the 'left' subarray.
    // 'left' is nums[0...i].
    // 'mid' is nums[i+1...j].
    // 'right' is nums[j+1...n-1].
    // 'i' can range from 0 to n-3 to ensure 'mid' and 'right' are non-empty.
    for (int i = 0; i < n - 2; i++) {
        long long s1 = prefix_sum[i]; // Sum of the 'left' subarray

        // Ensure j_min_ptr and j_max_ptr start at least i+1.
        // The 'mid' subarray must begin after 'left' ends.
        if (j_min_ptr <= i) {
            j_min_ptr = i + 1;
        }
        if (j_max_ptr <= i) {
            j_max_ptr = i + 1;
        }

        // Condition 1: sum(left) <= sum(mid)
        // s1 <= prefix_sum[j] - s1
        // 2 * s1 <= prefix_sum[j]
        // Move j_min_ptr to find the smallest 'j' such that prefix_sum[j] >= 2 * s1.
        // 'j' must also be at most n-2 (to ensure 'right' subarray is non-empty).
        while (j_min_ptr <= n - 2 && prefix_sum[j_min_ptr] < 2 * s1) {
            j_min_ptr++;
        }

        // Condition 2: sum(mid) <= sum(right)
        // prefix_sum[j] - s1 <= total_sum - prefix_sum[j]
        // 2 * prefix_sum[j] <= total_sum + s1
        // prefix_sum[j] <= (total_sum + s1) / 2
        // Move j_max_ptr to find the smallest 'j' such that prefix_sum[j] > (total_sum + s1) / 2.
        // The valid 'j' for this upper bound will be up to j_max_ptr - 1.
        // 'j' must also be at most n-2.
        while (j_max_ptr <= n - 2 && prefix_sum[j_max_ptr] <= (total_sum + s1) / 2) {
            j_max_ptr++;
        }

        // If j_min_ptr is within the valid range for 'j' (up to n-2)
        // and if there are valid 'j' values (j_min_ptr < j_max_ptr),
        // then add the count of valid 'j's for the current 'i'.
        // The valid 'j' indices are [j_min_ptr, j_max_ptr - 1].
        if (j_min_ptr <= n - 2 && j_min_ptr < j_max_ptr) {
            count += (j_max_ptr - j_min_ptr);
        }
    }

    free(prefix_sum);
    return count;
}