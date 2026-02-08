#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize, int* conditions, int conditionsSize) {
    int ops = 0;
    for (int i = 0; i < conditionsSize; ++i) {
        bool found = false;
        for (int j = 0; j < numsSize; ++j) {
            if (nums[j] == conditions[i]) {
                found = true;
                break;
            }
        }
        if (!found) {
            ops++;
        }
    }
    return ops;
}