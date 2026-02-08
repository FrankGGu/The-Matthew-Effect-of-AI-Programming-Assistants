#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int maxSubarrayMinProduct(int* nums, int numsSize) {
    long long maxProduct = 0;
    long long mod = 1000000007;

    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            long long minVal = nums[i];
            long long sum = 0;
            for (int k = i; k <= j; k++) {
                minVal = min(minVal, (long long)nums[k]);
                sum += nums[k];
            }
            maxProduct = max(maxProduct, minVal * sum);
        }
    }
    return (int)(maxProduct % mod);
}