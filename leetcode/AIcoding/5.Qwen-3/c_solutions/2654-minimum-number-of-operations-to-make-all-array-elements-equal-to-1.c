#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        while (nums[i] != 1) {
            if (nums[i] % 2 == 0) {
                nums[i] /= 2;
            } else {
                nums[i] += 1;
            }
            count++;
        }
    }
    return count;
}