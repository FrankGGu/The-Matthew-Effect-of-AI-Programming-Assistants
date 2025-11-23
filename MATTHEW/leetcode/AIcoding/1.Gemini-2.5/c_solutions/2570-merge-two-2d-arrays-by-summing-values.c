#include <stdlib.h> // Required for malloc, calloc, free

#define MAX_POSSIBLE_ID 1001 // IDs are 0-indexed, so if max ID is 1000, we need size 1001.

int** mergeArrays(int** nums1, int nums1Size, int* nums1ColSize, int** nums2, int nums2Size, int* nums2ColSize, int* returnSize, int** returnColumnSizes) {
    // Use a temporary array to store the sum of values for each ID.
    // Initialize all elements to 0 using calloc.
    int* sums = (int*)calloc(MAX_POSSIBLE_ID, sizeof(int));

    // Process nums1: add values to the corresponding ID in the sums array.
    for (int i = 0; i < nums1Size; i++) {
        int id = nums1[i][0];
        int value = nums1[i][1];
        sums[id] += value;
    }

    // Process nums2: add values to the corresponding ID in the sums array.
    for (int i = 0; i < nums2Size; i++) {
        int id = nums2[i][0];
        int value = nums2[i][1];
        sums[id] += value;
    }

    // Count how many unique IDs have a non-zero sum to determine the size of the result array.
    int count = 0;
    for (int i = 0; i < MAX_POSSIBLE_ID; i++) {
        if (sums[i] != 0) {
            count++;
        }
    }

    // Allocate memory for the result array and its column sizes.
    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    // Populate the result array with [id, summed_value] pairs, sorted by ID.
    int currentResultIndex = 0;
    for (int i = 0; i < MAX_POSSIBLE_ID; i++) {
        if (sums[i] != 0) {
            // Allocate memory for the current [id, value] pair.
            result[currentResultIndex] = (int*)malloc(2 * sizeof(int));
            result[currentResultIndex][0] = i;      // ID
            result[currentResultIndex][1] = sums[i]; // Summed value

            // Each inner array has 2 columns.
            (*returnColumnSizes)[currentResultIndex] = 2; 
            currentResultIndex++;
        }
    }

    // Free the temporary sums array.
    free(sums);

    return result;
}