#include <stdio.h>
#include <stdlib.h>

long long zeroFilledSubarrays(int* nums, int numsSize) {
    long long count = 0;
    long long consecutiveZeros = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            consecutiveZeros++;
            count += consecutiveZeros;
        } else {
            consecutiveZeros = 0;
        }
    }

    return count;
}