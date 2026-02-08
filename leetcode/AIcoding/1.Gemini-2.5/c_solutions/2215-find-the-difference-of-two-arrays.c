#include <stdlib.h> // For malloc, free
#include <stdbool.h> // For bool type

int** findDifference(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize, int** returnColumnSizes) {
    // Offset for boolean arrays to handle negative numbers (-1000 to 1000)
    // -1000 maps to index 0, 0 maps to index 1000, 1000 maps to index 2000
    const int OFFSET = 1000;
    // The range of values is from -1000 to 1000, which is 2001 distinct values.
    // Array indices will be from 0 to 2000.
    const int MAX_ARRAY_SIZE = 2001;

    // Use boolean arrays to mark presence of numbers in nums1 and nums2.
    // Initialized to false by default for static/global arrays, but for stack arrays,
    // explicit initialization is safer.
    bool seenInNums1[MAX_ARRAY_SIZE];
    bool seenInNums2[MAX_ARRAY_SIZE];

    // Initialize boolean arrays to false
    for (int i = 0; i < MAX_ARRAY_SIZE; i++) {
        seenInNums1[i] = false;
        seenInNums2[i] = false;
    }

    // Populate seenInNums1 for elements present in nums1
    for (int i = 0; i < nums1Size; i++) {
        seenInNums1[nums1[i] + OFFSET] = true;
    }

    // Populate seenInNums2 for elements present in nums2
    for (int i = 0; i < nums2Size; i++) {
        seenInNums2[nums2[i] + OFFSET] = true;
    }

    // Prepare the result structure
    *returnSize = 2; // Always two arrays in the result
    *returnColumnSizes = (int*) malloc(sizeof(int) * 2);
    int** result = (int**) malloc(sizeof(int*) * 2);

    // Temporary lists to store elements before final allocation
    // Max possible distinct elements in each list is MAX_ARRAY_SIZE
    int* temp_list0 = (int*) malloc(sizeof(int) * MAX_ARRAY_SIZE);
    int* temp_list1 = (int*) malloc(sizeof(int) * MAX_ARRAY_SIZE);
    int count0 = 0; // Counter for elements in result[0]
    int count1 = 0; // Counter for elements in result[1]

    // Build result[0]: distinct elements in nums1 that are not present in nums2
    // Iterate through the entire possible range of values (-1000 to 1000)
    for (int i = 0; i < MAX_ARRAY_SIZE; i++) {
        // If the number (i - OFFSET) was seen in nums1 AND not seen in nums2
        if (seenInNums1[i] && !seenInNums2[i]) {
            temp_list0[count0++] = i - OFFSET;
        }
    }

    // Build result[1]: distinct elements in nums2 that are not present in nums1
    // Iterate through the entire possible range of values (-1000 to 1000)
    for (int i = 0; i < MAX_ARRAY_SIZE; i++) {
        // If the number (i - OFFSET) was seen in nums2 AND not seen in nums1
        if (seenInNums2[i] && !seenInNums1[i]) {
            temp_list1[count1++] = i - OFFSET;
        }
    }

    // Allocate final arrays for the result and copy elements from temporary lists
    result[0] = (int*) malloc(sizeof(int) * count0);
    for (int i = 0; i < count0; i++) {
        result[0][i] = temp_list0[i];
    }
    (*returnColumnSizes)[0] = count0; // Set size for the first sub-array

    result[1] = (int*) malloc(sizeof(int) * count1);
    for (int i = 0; i < count1; i++) {
        result[1][i] = temp_list1[i];
    }
    (*returnColumnSizes)[1] = count1; // Set size for the second sub-array

    // Free temporary memory
    free(temp_list0);
    free(temp_list1);

    return result;
}