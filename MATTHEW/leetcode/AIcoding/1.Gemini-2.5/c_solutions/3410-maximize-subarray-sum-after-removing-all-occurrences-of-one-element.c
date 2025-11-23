#include <limits.h>
#include <stdlib.h> // For qsort
#include <stdbool.h> // For bool type

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maximizeSubarraySumAfterRemovingAllOccurrencesOfOneElement(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    // If there's only one element, removing it makes the array empty, sum is 0.
    if (numsSize == 1) {
        return 0;
    }

    // Step 1: Get unique elements
    // Create a copy to sort for unique elements
    int* sorted_nums = (int*)malloc(numsSize * sizeof(int));
    if (sorted_nums == NULL) {
        // Handle memory allocation failure
        return 0; 
    }
    for (int i = 0; i < numsSize; i++) {
        sorted_nums[i] = nums[i];
    }
    qsort(sorted_nums, numsSize, sizeof(int), compare);

    int* unique_elements = (int*)malloc(numsSize * sizeof(int)); // Max possible unique elements is numsSize
    if (unique_elements == NULL) {
        free(sorted_nums);
        return 0; // Handle memory allocation failure
    }
    int unique_count = 0;
    if (numsSize > 0) {
        unique_elements[unique_count++] = sorted_nums[0];
        for (int i = 1; i < numsSize; i++) {
            if (sorted_nums[i] != sorted_nums[i-1]) {
                unique_elements[unique_count++] = sorted_nums[i];
            }
        }
    }
    free(sorted_nums);

    // If there's only one unique element type, removing it results in an empty array.
    if (unique_count == 1) {
        free(unique_elements);
        return 0;
    }

    int overall_max_sum = INT_MIN; // Initialize with smallest possible sum

    // Step 2: For each unique element, calculate max subarray sum of the modified array
    for (int i = 0; i < unique_count; i++) {
        int element_to_remove = unique_elements[i];

        int current_max_for_removal = 0;
        int global_max_for_removal = INT_MIN; // Initialize for this specific removal.

        bool has_elements_after_removal = false; 
        bool first_element_processed = false;

        for (int j = 0; j < numsSize; j++) {
            if (nums[j] != element_to_remove) {
                if (!first_element_processed) {
                    current_max_for_removal = nums[j];
                    global_max_for_removal = nums[j];
                    first_element_processed = true;
                } else {
                    current_max_for_removal = (nums[j] > current_max_for_removal + nums[j]) ? nums[j] : (current_max_for_removal + nums[j]);
                    if (current_max_for_removal > global_max_for_removal) {
                        global_max_for_removal = current_max_for_removal;
                    }
                }
                has_elements_after_removal = true;
            }
        }

        if (!has_elements_after_removal) {
            // All elements were removed (e.g., if the original array consisted only of 'element_to_remove').
            // An empty subarray has a sum of 0.
            if (0 > overall_max_sum) {
                overall_max_sum = 0;
            }
        } else {
            if (global_max_for_removal > overall_max_sum) {
                overall_max_sum = global_max_for_removal;
            }
        }
    }

    free(unique_elements);

    return overall_max_sum;
}