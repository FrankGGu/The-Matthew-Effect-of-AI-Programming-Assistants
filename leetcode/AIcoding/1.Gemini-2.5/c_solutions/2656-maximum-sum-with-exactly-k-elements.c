#include <stddef.h> // Required for size_t

int maximizeSum(int* nums, int numsSize, int k) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    long long sum = (long long)k * (2LL * max_val + k - 1) / 2LL;
    return (int)sum;
}