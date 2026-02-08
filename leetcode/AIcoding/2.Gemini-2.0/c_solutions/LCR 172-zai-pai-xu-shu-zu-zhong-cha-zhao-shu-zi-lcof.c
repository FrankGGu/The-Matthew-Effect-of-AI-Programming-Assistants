#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countOccurrences(int* nums, int numsSize, int target) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            count++;
        }
    }
    return count;
}