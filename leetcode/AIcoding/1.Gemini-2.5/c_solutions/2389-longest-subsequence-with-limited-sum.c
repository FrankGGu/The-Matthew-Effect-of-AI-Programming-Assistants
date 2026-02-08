#include <stdlib.h> // For malloc, qsort
#include <string.h> // Not strictly needed

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int find_max_length_idx(long long* arr, int size, int target) {
    int low = 0;
    int high = size - 1;
    int ans_idx = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] <= target) {
            ans_idx = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ans_idx;
}

int* answerQueries(int* nums, int numsSize, int* queries, int queriesSize, int* returnSize) {
    // 1. Sort nums in non-decreasing order
    qsort(nums, numsSize, sizeof(int), compareIntegers);

    // 2. Compute prefix sums (cumulative sums)
    // Use long long to prevent potential overflow as sums can reach 1000 * 10^6 = 10^9
    long long* prefix_sums = (long long*) malloc(numsSize * sizeof(long long));
    if (numsSize > 0) {
        prefix_sums[0] = nums[0];
        for (int i = 1; i < numsSize; ++i) {
            prefix_sums[i] = prefix_sums[i-1] + nums[i];
        }
    }

    // 3. Process each query
    int* results = (int*) malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int q_idx = 0; q_idx < queriesSize; ++q_idx) {
        int current_query = queries[q_idx];

        // Find the largest index `idx` in prefix_sums such that prefix_sums[idx] <= current_query
        int idx = find_max_length_idx(prefix_sums, numsSize, current_query);

        // The length of the subsequence is idx + 1. If idx is -1, length is 0.
        results[q_idx] = (idx == -1) ? 0 : (idx + 1);
    }

    // Free the dynamically allocated memory for prefix_sums
    free(prefix_sums);

    return results;
}