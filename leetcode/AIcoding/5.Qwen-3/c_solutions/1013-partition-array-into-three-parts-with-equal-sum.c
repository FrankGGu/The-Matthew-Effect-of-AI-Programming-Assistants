#include <stdio.h>
#include <stdlib.h>

int canPartition(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    if (total % 3 != 0) {
        return 0;
    }
    int target = total / 3;
    int current = 0;
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        current += nums[i];
        if (current == target) {
            count++;
            current = 0;
        }
    }
    return count >= 3;
}