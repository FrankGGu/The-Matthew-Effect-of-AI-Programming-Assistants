#include <stdlib.h> // For malloc, free, qsort, bsearch

typedef struct {
    int val;
    int idx;
} ValueIndexPair;

int comparePairs(const void *a, const void *b) {
    return ((ValueIndexPair*)a)->val - ((ValueIndexPair*)b)->val;
}

int minOperations(int* target, int targetSize, int* arr, int arrSize) {
    if (targetSize == 0) {
        return 0;
    }

    // Step 1: Create an array of (value, index) pairs for target and sort it.
    // This allows efficient lookup of target element's original index using binary search.
    ValueIndexPair *target_pairs = (ValueIndexPair*)malloc(targetSize * sizeof(ValueIndexPair));
    for (int i = 0; i < targetSize; ++i) {
        target_pairs[i].val = target[i];
        target_pairs[i].idx = i;
    }
    qsort(target_pairs, targetSize, sizeof(ValueIndexPair), comparePairs);

    // Step 2: Find the Longest Increasing Subsequence (LIS) of target indices present in arr.
    // 'tails' array stores the smallest tail of all increasing subsequences of length i+1.
    // 'len' is the current length of the LIS.
    int* tails = (int*)malloc(targetSize * sizeof(int));
    int len = 0; // Current length of the LIS

    for (int i = 0; i < arrSize; ++i) {
        int num = arr[i];

        // Use bsearch to find if num is in target and get its original index.
        ValueIndexPair key = { .val = num, .idx = 0 }; 
        ValueIndexPair *found_pair = (ValueIndexPair*)bsearch(&key, target_pairs, targetSize, sizeof(ValueIndexPair), comparePairs);

        if (found_pair) { // If num is found in target
            int target_idx = found_pair->idx;

            // Find position for target_idx in 'tails' using binary search (lower_bound).
            // This finds the first element in 'tails' that is greater than or equal to target_idx.
            int low = 0, high = len - 1;
            int pos = len; // Default to append if target_idx is greater than all elements in tails

            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (tails[mid] >= target_idx) {
                    pos = mid;
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }

            if (pos == len) { // target_idx is greater than all elements in tails, extend LIS.
                tails[len++] = target_idx;
            } else { // Replace the element at 'pos' to potentially allow for a longer LIS later.
                tails[pos] = target_idx;
            }
        }
    }

    // Step 3: Calculate minimum operations.
    // The minimum operations needed is targetSize - length_of_LIS.
    // This is because we need to insert (targetSize - length_of_LIS) elements
    // from 'target' that are not part of the longest common subsequence.
    int min_operations = targetSize - len;

    // Free allocated memory
    free(target_pairs);
    free(tails);

    return min_operations;
}