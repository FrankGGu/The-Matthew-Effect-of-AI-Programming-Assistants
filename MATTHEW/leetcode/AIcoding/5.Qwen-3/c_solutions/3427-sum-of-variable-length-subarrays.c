#include <stdio.h>
#include <stdlib.h>

int sumSubarrayAverages(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        int sum = 0;
        for (int j = i; j < numsSize; j++) {
            sum += nums[j];
            total += sum / (j - i + 1);
        }
    }
    return total;
}