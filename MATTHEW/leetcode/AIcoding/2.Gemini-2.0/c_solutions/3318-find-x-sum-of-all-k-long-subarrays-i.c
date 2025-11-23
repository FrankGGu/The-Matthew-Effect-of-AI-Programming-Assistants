#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int kSum(int* nums, int numsSize, int k, int target) {
    long long sum = 0;
    for (int i = 0; i <= numsSize - k; i++) {
        sum += (long long)nums[i + k - 1];
    }
    return sum % 1000000007;
}