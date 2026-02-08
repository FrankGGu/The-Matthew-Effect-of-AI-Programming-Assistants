#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxDistinctElements(int* nums, int numsSize, int k) {
    if (numsSize == 0) {
        return 0;
    }

    // 1. Sort the array to group identical elements
    qsort(nums, numsSize, sizeof(int), compare);

    // Use a dynamic array to store the number of "excess" elements for each distinct value
    // An "excess" element is a duplicate that can be changed using one operation.
    // The maximum number of unique elements is numsSize, so max excess_counts is numsSize.
    int* excess_counts = (int*)malloc(numsSize * sizeof(int));
    if (excess_counts == NULL) {
        // Handle allocation error (though LeetCode environments usually guarantee success)
        return -1; 
    }
    int excess_count_idx = 0;

    int initial_distinct_count = 0;
    int i = 0;
    while (i < numsSize) {
        int current_val = nums[i];
        int count = 0;
        // Count occurrences of the current value
        while (i < numsSize && nums[i] == current_val) {
            count++;
            i++;
        }

        // Each unique value contributes one to the initial distinct count
        initial_distinct_count++;

        // If there are duplicates (count > 1), we have (count - 1) "excess" elements
        // that can be changed using one operation each.
        if (count > 1) {
            excess_counts[excess_count_idx++] = count - 1;
        }
    }

    // 2. Sort the excess_counts array in ascending order.
    // This ensures we prioritize using operations on groups of duplicates that require fewer operations.
    qsort(excess_counts, excess_count_idx, sizeof(int), compare);

    // 3. Apply operations to maximize distinct elements
    int final_distinct_count = initial_distinct_count;
    for (int j = 0; j < excess_count_idx; j++) {
        int removals_needed = excess_counts[j];
        if (k >= removals_needed) {
            // We have enough operations to change all 'removals_needed' duplicates
            // into new distinct values.
            k -= removals_needed;
            final_distinct_count += removals_needed;
        } else {
            // We don't have enough operations to change all duplicates for this group.
            // Use all remaining 'k' operations to change 'k' of these duplicates
            // into new distinct values.
            final_distinct_count += k;
            k = 0; // All operations are used
            break; // No more operations left
        }
    }

    // Free the dynamically allocated memory
    free(excess_counts);

    return final_distinct_count;
}