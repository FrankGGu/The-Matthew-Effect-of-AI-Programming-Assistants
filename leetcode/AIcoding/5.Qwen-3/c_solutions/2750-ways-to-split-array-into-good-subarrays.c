#include <stdio.h>
#include <stdlib.h>

int numberOfGoodSubarrays(int* nums, int numsSize) {
    int count = 0;
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            total = (total + count) % 1000000007;
            count++;
        }
    }
    return total;
}