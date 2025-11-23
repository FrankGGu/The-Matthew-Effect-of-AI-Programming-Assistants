#include <stdio.h>
#include <stdlib.h>

long long sumOfSubsequencePowers(int* nums, int numsSize) {
    long long result = 0;
    for (int i = 0; i < numsSize; i++) {
        long long power = 1;
        for (int j = i; j < numsSize; j++) {
            power *= nums[j];
            result += power;
        }
    }
    return result;
}