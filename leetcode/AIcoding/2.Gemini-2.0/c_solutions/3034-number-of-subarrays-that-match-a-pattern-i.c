#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countMatchingSubarrays(int* nums, int numsSize, int* pattern, int patternSize) {
    int count = 0;
    for (int i = 0; i <= numsSize - patternSize - 1; i++) {
        int match = 1;
        for (int j = 0; j < patternSize; j++) {
            if ((nums[i + j + 1] > nums[i + j] && pattern[j] != 1) ||
                (nums[i + j + 1] < nums[i + j] && pattern[j] != -1) ||
                (nums[i + j + 1] == nums[i + j] && pattern[j] != 0)) {
                match = 0;
                break;
            }
        }
        if (match) {
            count++;
        }
    }
    return count;
}