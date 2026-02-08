#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSubarray(int* nums, int numsSize) {
    long long sum = 0;
    long long minSum = LLONG_MAX;

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (sum < minSum) {
            minSum = sum;
        }
        if (sum > 0) {
            sum = 0;
        }
    }

    return sum == 0 ? 1 : -minSum + 1;
}