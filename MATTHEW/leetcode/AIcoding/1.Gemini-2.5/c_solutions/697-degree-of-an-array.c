#include <string.h> // Required for memset, though a loop is used for initialization

int findShortestSubArray(int* nums, int numsSize) {
    const int MAX_VAL = 50000; // Maximum possible value for nums[i] + 1

    int freq[MAX_VAL];
    int first_idx[MAX_VAL];
    int last_idx[MAX_VAL];

    // Initialize arrays
    for (int i = 0; i < MAX_VAL; ++i) {
        freq[i] = 0;
        first_idx[i] = -1; // -1 indicates the number has not been seen yet
        last_idx[i] = 0;   // Will be updated if the number appears
    }

    // Populate frequency, first occurrence index, and last occurrence index
    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        freq[num]++;
        if (first_idx[num] == -1) {
            first_idx[num] = i;
        }
        last_idx[num] = i;
    }

    // Find the degree of the array (maximum frequency)
    int degree = 0;
    for (int i = 0; i < MAX_VAL; ++i) {
        if (freq[i] > degree) {
            degree = freq[i];
        }
    }

    // Find the shortest subarray with the same degree
    int min_length = numsSize; // Initialize with the maximum possible length

    for (int i = 0; i < MAX_VAL; ++i) {
        if (freq[i] == degree) {
            int current_length = last_idx[i] - first_idx[i] + 1;
            if (current_length < min_length) {
                min_length = current_length;
            }
        }
    }

    return min_length;
}