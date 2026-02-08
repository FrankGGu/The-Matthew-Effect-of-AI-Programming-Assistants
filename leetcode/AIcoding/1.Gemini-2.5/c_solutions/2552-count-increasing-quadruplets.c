#include <stdlib.h> // Required for malloc and calloc

long long countIncreasingQuadruplets(int* nums, int numsSize) {
    int n = numsSize;
    long long ans = 0;

    if (n < 4) {
        return 0;
    }

    // left_smaller[j][val] stores the count of numbers nums[i] such that i < j and nums[i] < val.
    // Values in nums are 1-indexed (1 to n). So, val goes from 1 to n.
    // Array indices for `left_smaller` are 0 to n-1 for `j`, and 0 to n for `val`.
    int** left_smaller = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; ++i) {
        left_smaller[i] = (int*)calloc(n + 1, sizeof(int)); // calloc initializes to 0
    }

    // Precompute left_smaller table
    // left_smaller[0][val] is 0 for all val (no elements before index 0)
    for (int j = 1; j < n; ++j) {
        // Copy counts from the previous index j-1
        for (int val = 1; val <= n; ++val) {
            left_smaller[j][val] = left_smaller[j-1][val];
        }
        // For any value 'val' greater than nums[j-1], nums[j-1] contributes to its count.
        // So, we increment counts for val from nums[j-1] + 1 up to n.
        for (int val = nums[j-1] + 1; val <= n; ++val) {
            left_smaller[j][val]++;
        }
    }

    // right_greater[k][val] stores the count of numbers nums[l] such that l > k and nums[l] > val.
    // Array indices for `right_greater` are 0 to n-1 for `k`, and 0 to n for `val`.
    int** right_greater = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; ++i) {
        right_greater[i] = (int*)calloc(n + 1, sizeof(int)); // calloc initializes to 0
    }

    // Precompute right_greater table
    // right_greater[n-1][val] is 0 for all val (no elements after index n-1)
    for (int k = n - 2; k >= 0; --k) {
        // Copy counts from the next index k+1
        for (int val = 1; val <= n; ++val) {
            right_greater[k][val] = right_greater[k+1][val];
        }
        // For any value 'val' smaller than nums[k+1], nums[k+1] contributes to its count.
        // So, we increment counts for val from 1 up to nums[k+1] - 1.
        for (int val = 1; val < nums[k+1]; ++val) {
            right_greater[k][val]++;
        }
    }

    // Iterate j and k to find quadruplets (i, j, k, l)
    // Conditions: 0 <= i < j < k < l < n
    //             nums[i] < nums[k] < nums[j] < nums[l]
    // We fix j and k, then use precomputed tables to find counts of i and l.
    // The inner loop for k starts from j+1, ensuring j < k.
    // The condition nums[k] < nums[j] is checked explicitly.
    for (int j = 0; j < n; ++j) {
        for (int k = j + 1; k < n; ++k) {
            if (nums[k] < nums[j]) {
                // count_i: number of i such that i < j and nums[i] < nums[k]
                // This is directly available from left_smaller[j][nums[k]]
                long long count_i = left_smaller[j][nums[k]];

                // count_l: number of l such that l > k and nums[l] > nums[j]
                // This is directly available from right_greater[k][nums[j]]
                long long count_l = right_greater[k][nums[j]];

                ans += count_i * count_l;
            }
        }
    }

    // Free allocated memory
    for (int i = 0; i < n; ++i) {
        free(left_smaller[i]);
        free(right_greater[i]);
    }
    free(left_smaller);
    free(right_greater);

    return ans;
}