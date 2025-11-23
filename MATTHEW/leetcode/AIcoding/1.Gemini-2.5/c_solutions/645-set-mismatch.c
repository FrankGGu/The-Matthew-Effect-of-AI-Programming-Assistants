#include <stdlib.h> // For malloc and calloc

int* findErrorNums(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 2);
    *returnSize = 2;

    // Use a frequency array to count occurrences of each number.
    // Size numsSize + 1 because numbers are 1-indexed up to numsSize.
    // calloc initializes all elements to 0.
    int* freq = (int*)calloc(numsSize + 1, sizeof(int));

    // Populate the frequency array
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    // Iterate from 1 to numsSize to find the duplicate and the missing number
    for (int i = 1; i <= numsSize; i++) {
        if (freq[i] == 2) {
            result[0] = i; // Found the number that appears twice
        } else if (freq[i] == 0) {
            result[1] = i; // Found the missing number
        }
    }

    // Free the dynamically allocated frequency array
    free(freq);

    return result;
}