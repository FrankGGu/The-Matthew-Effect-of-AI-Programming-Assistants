#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countPairs(int* nums, int numsSize) {
    long long count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] <= nums[j]) {
                count++;
            }
        }
    }
    return count;
}