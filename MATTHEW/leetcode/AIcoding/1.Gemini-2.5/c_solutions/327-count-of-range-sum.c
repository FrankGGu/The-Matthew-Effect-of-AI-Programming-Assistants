#include <stdlib.h> // For malloc, free

int mergeSortAndCount(long long* prefixSums, int start, int end, long long lower, long long upper, long long* temp) {
    if (start == end) {
        return 0;
    }

    int mid = start + (end - start) / 2;
    int count = mergeSortAndCount(prefixSums, start, mid, lower, upper, temp) +
                mergeSortAndCount(prefixSums, mid + 1, end, lower, upper, temp);

    // Count pairs (i, j) where i is in [start, mid] and j is in [mid+1, end]
    // such that lower <= prefixSums[j] - prefixSums[i] <= upper
    // This is equivalent to prefixSums[i] + lower <= prefixSums[j] <= prefixSums[i] + upper
    int k1 = mid + 1; // Pointer for lower bound (first element >= prefixSums[i] + lower)
    int k2 = mid + 1; // Pointer for upper bound (first element > prefixSums[i] + upper)
    for (int i = start; i <= mid; ++i) {
        // Find first k1 such that prefixSums[k1] >= prefixSums[i] + lower
        while (k1 <= end && prefixSums[k1] < prefixSums[i] + lower) {
            k1++;
        }
        // Find first k2 such that prefixSums[k2] > prefixSums[i] + upper
        while (k2 <= end && prefixSums[k2] <= prefixSums[i] + upper) {
            k2++;
        }
        count += (k2 - k1);
    }

    // Standard merge step: merge sorted halves [start, mid] and [mid+1, end]
    int p1 = start;
    int p2 = mid + 1;
    int p = 0; // Index for temp array

    while (p1 <= mid && p2 <= end) {
        if (prefixSums[p1] < prefixSums[p2]) {
            temp[p++] = prefixSums[p1++];
        } else {
            temp[p++] = prefixSums[p2++];
        }
    }
    while (p1 <= mid) {
        temp[p++] = prefixSums[p1++];
    }
    while (p2 <= end) {
        temp[p++] = prefixSums[p2++];
    }

    // Copy sorted elements back to prefixSums array for the current segment
    for (int i = 0; i < p; ++i) {
        prefixSums[start + i] = temp[i];
    }

    return count;
}

int countRangeSum(int* nums, int numsSize, int lower, int upper) {
    if (numsSize == 0) {
        return 0;
    }

    // prefixSums[i] stores sum of nums[0]...nums[i-1]
    // prefixSums[0] = 0
    // The prefixSums array will have size numsSize + 1
    long long* prefixSums = (long long*)malloc((numsSize + 1) * sizeof(long long));
    if (!prefixSums) {
        return 0;
    }

    prefixSums[0] = 0;
    for (int i = 0; i < numsSize; ++i) {
        prefixSums[i + 1] = prefixSums[i] + nums[i];
    }

    // Temporary array for merge sort
    long long* temp = (long long*)malloc((numsSize + 1) * sizeof(long long));
    if (!temp) {
        free(prefixSums);
        return 0;
    }

    // Cast lower and upper to long long before passing to helper function
    int result = mergeSortAndCount(prefixSums, 0, numsSize, (long long)lower, (long long)upper, temp);

    free(prefixSums);
    free(temp);

    return result;
}