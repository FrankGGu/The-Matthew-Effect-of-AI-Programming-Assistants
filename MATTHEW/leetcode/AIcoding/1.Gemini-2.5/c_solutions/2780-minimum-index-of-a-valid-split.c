#include <stdlib.h>

int minimumIndex(int* nums, int numsSize) {
    if (numsSize < 2) {
        return -1;
    }

    // Step 1: Find the overall dominant element candidate using Boyer-Moore Voting Algorithm
    int candidate = -1;
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (count == 0) {
            candidate = nums[i];
            count = 1;
        } else if (nums[i] == candidate) {
            count++;
        } else {
            count--;
        }
    }

    // Step 2: Verify if the candidate is truly dominant in the entire array
    // and get its total count.
    int total_dominant_count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == candidate) {
            total_dominant_count++;
        }
    }

    // If the candidate is not dominant in the entire array, no split can be valid.
    // (An element 'x' dominant in two parts must be dominant in the whole array.)
    if ((long long)total_dominant_count * 2 <= numsSize) {
        return -1;
    }

    // Step 3: Iterate through possible split points 'i'
    // 'i' represents the last index of the left subarray.
    // Left subarray: nums[0...i] (length i + 1)
    // Right subarray: nums[i+1...numsSize-1] (length numsSize - (i + 1))

    int current_left_dominant_count = 0;
    // The count of the dominant element in the right subarray starts as the total count
    // and is decremented as elements are moved from right to left conceptually.
    int current_right_dominant_count = total_dominant_count;

    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] == candidate) {
            current_left_dominant_count++;
            current_right_dominant_count--;
        }

        long long left_len = i + 1;
        long long right_len = numsSize - (i + 1);

        // Check if the candidate is dominant in both subarrays
        // Dominant means its count * 2 is strictly greater than the subarray length
        if ((long long)current_left_dominant_count * 2 > left_len &&
            (long long)current_right_dominant_count * 2 > right_len) {
            return i;
        }
    }

    // No valid split found
    return -1;
}