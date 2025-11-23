#include <stddef.h>

long long sumImbalanceNumbers(int* nums, int numsSize) {
    long long totalImbalanceSum = 0;

    for (int k = 0; k < numsSize; ++k) {
        for (int l = k + 1; l < numsSize; ++l) {
            if (nums[k] < nums[l] && nums[l] - nums[k] > 1) {
                totalImbalanceSum += (long long)(k + 1) * (numsSize - l);
            }
        }
    }

    return totalImbalanceSum;
}