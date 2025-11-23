#include <stdio.h>
#include <stdlib.h>

long long minIncrements(int* nums, int numsSize, int target) {
    long long res = 0;
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (sum >= target) {
        return 0;
    }
    return (long long)target - sum;
}