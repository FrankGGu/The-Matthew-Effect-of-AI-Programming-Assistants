#include <stdlib.h> // For malloc, qsort, free
#include <string.h> // For strcmp, strlen

typedef struct {
    const char* trimmed_str;
    int original_index;
} TrimmedNum;

int compareTrimmedNums(const void* a, const void* b) {
    const TrimmedNum* num1 = (const TrimmedNum*)a;
    const TrimmedNum* num2 = (const TrimmedNum*)b;

    // Primary sort criterion: lexicographical comparison of trimmed strings
    int cmp = strcmp(num1->trimmed_str, num2->trimmed_str);
    if (cmp != 0) {
        return cmp;
    }

    // Secondary sort criterion: original index (for stability when trimmed strings are equal)
    return num1->original_index - num2->original_index;
}

int* smallestTrimmedNumbers(char** nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // Determine the length of the numbers. All numbers have the same length.
    int num_len = strlen(nums[0]);

    // Allocate memory for the results array
    int* results = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    // Allocate a temporary array of TrimmedNum structs.
    // This array will be populated and sorted for each query.
    TrimmedNum* temp_nums = (TrimmedNum*)malloc(numsSize * sizeof(TrimmedNum));

    // Process each query
    for (int q_idx = 0; q_idx < queriesSize; ++q_idx) {
        int k = queries[q_idx][0];
        int trim = queries[q_idx][1];

        // Populate the temporary array with pointers to the trimmed parts of the original strings
        // and their original indices.
        // The trimmed part starts at (num_len - trim) characters from the beginning of the string.
        for (int i = 0; i < numsSize; ++i) {
            temp_nums[i].trimmed_str = &nums[i][num_len - trim];
            temp_nums[i].original_index = i;
        }

        // Sort the temporary array using the custom comparison function
        qsort(temp_nums, numsSize, sizeof(TrimmedNum), compareTrimmedNums);

        // The k-th smallest number (1-indexed) is at index k-1 in the sorted array.
        results[q_idx] = temp_nums[k - 1].original_index;
    }

    // Free the temporary array
    free(temp_nums);

    return results;
}