#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize, int k) {
    int prefixSum = 0;
    int remainderCount[10000] = {0};
    int result = 0;

    for (int i = 0; i < numsSize; i++) {
        prefixSum += nums[i];
        int rem = (prefixSum % k + k) % k;
        if (rem == 0) {
            result++;
        } else {
            remainderCount[rem]++;
        }
    }

    int total = 0;
    for (int i = 1; i < k; i++) {
        if (remainderCount[i] > 0) {
            total += remainderCount[i];
        }
    }

    return total;
}