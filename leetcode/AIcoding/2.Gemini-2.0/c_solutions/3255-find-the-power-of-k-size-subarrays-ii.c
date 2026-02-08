#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long findPowerSum(int* nums, int numsSize, int k) {
    long long powerSum = 0;
    if (numsSize < k) return 0;

    for (int i = 0; i <= numsSize - k; i++) {
        long long subarraySum = 0;
        for (int j = i; j < i + k; j++) {
            subarraySum += nums[j];
        }
        powerSum += subarraySum * subarraySum;
    }

    return powerSum;
}