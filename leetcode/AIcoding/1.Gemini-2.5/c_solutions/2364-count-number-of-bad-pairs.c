#include <stdlib.h> // Required for malloc, qsort, free

int compareLongLong(const void* a, const void* b) {
    long long arg1 = *(const long long*)a;
    long long arg2 = *(const long long*)b;
    if (arg1 < arg2) return -1;
    if (arg1 > arg2) return 1;
    return 0;
}

long long countBadPairs(int* nums, int numsSize) {
    // If there are 0 or 1 elements, no pairs (i, j) with i < j exist.
    if (numsSize <= 1) {
        return 0;
    }

    // Total number of possible pairs (i, j) with i < j is n * (n - 1) / 2.
    // This can be a large number, so use long long.
    long long totalPairs = (long long)numsSize * (numsSize - 1) / 2;

    // We want to count bad pairs where nums[i] + i != nums[j] + j.
    // It's easier to count good pairs where nums[i] + i == nums[j] + j
    // and subtract from the total number of pairs.
    // Let's define val[k] = nums[k] + k.
    // A good pair is when val[i] == val[j].

    // Create a temporary array to store val[k] values.
    // nums[k] can be up to 10^9, k up to 10^5. Sum fits in long long.
    long long* val = (long long*)malloc(numsSize * sizeof(long long));
    if (val == NULL) {
        // Handle memory allocation failure, though unlikely in competitive programming context
        return -1; 
    }

    // Populate the val array
    for (int i = 0; i < numsSize; i++) {
        val[i] = (long long)nums[i] + i;
    }

    // Sort the val array to easily count frequencies of identical values
    qsort(val, numsSize, sizeof(long long), compareLongLong);

    long long goodPairs = 0;
    int i = 0;
    while (i < numsSize) {
        int j = i;
        // Count consecutive identical values
        while (j < numsSize && val[j] == val[i]) {
            j++;
        }
        // 'count' is the number of times val[i] appears
        long long count = j - i;

        // If a value appears 'count' times, it forms count * (count - 1) / 2 good pairs
        if (count > 1) {
            goodPairs += count * (count - 1) / 2;
        }
        // Move to the next distinct value
        i = j;
    }

    // Free the allocated memory
    free(val);

    // The number of bad pairs is total pairs minus good pairs
    return totalPairs - goodPairs;
}