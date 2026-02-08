#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(int* nums, int numsSize) {
    int count = 0;
    int minVal = 0;
    int maxVal = 0;
    int seen[100001] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0 && seen[nums[i]] == 0) {
            seen[nums[i]] = 1;
            count++;
        }
    }
    return count;
}