#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findLargestAlmostMissingInteger(int* nums, int numsSize) {
    if (numsSize == 0) {
        return -1;
    }

    // Sort the array in ascending order.
    qsort(nums, numsSize, sizeof(int), compare);

    // Initialize the result. -1 is used as a sentinel value.
    // If no such integer is found (e.g., array is empty), -1 will be returned.
    int largest_almost_missing = -1;

    // Use long long for 'last_unique_num' to safely handle potential intermediate
    // calculations like 'last_unique_num + 1' without overflow, especially if
    // nums[i] can be close to INT_MAX.
    long long last_unique_num = (long long)nums[0];

    // Iterate through the sorted array starting from the second element.
    // We process unique numbers and look for gaps.
    for (int i = 1; i < numsSize; ++i) {
        // Skip duplicate numbers. We only care about unique values for 'X-1'.
        if (nums[i] == last_unique_num) {
            continue;
        }

        // If the current unique number (nums[i]) is greater than
        // (the previous unique number + 1), it means that (previous unique number + 1)
        // is missing from the array, but (previous unique number) is present.
        // This makes (previous unique number + 1) an "almost missing" integer.
        if (nums[i] > last_unique_num + 1) {
            // Update largest_almost_missing if this newly found one is larger.
            // Cast back to int, assuming the problem guarantees the result fits in int.
            if ((int)(last_unique_num + 1) > largest_almost_missing) {
                largest_almost_missing = (int)(last_unique_num + 1);
            }
        }

        // Update last_unique_num to the current unique number.
        last_unique_num = (long long)nums[i];
    }

    // After the loop, the number immediately following the largest unique number
    // in the array (last_unique_num + 1) is always missing from the array,
    // and last_unique_num is present. Thus, it's an "almost missing" integer.
    // This must be considered as a potential candidate for the largest.
    // Again, cast to int.
    if ((int)(last_unique_num + 1) > largest_almost_missing) {
        largest_almost_missing = (int)(last_unique_num + 1);
    }

    return largest_almost_missing;
}