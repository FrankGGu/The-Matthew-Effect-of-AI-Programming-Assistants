#include <stddef.h>

long long zeroArrayTransformation(int* nums, int numsSize) {
    long long operations = 0;
    long long max_prefix_val = 0;

    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] > max_prefix_val) {
            operations += (nums[i] - max_prefix_val);
            max_prefix_val = nums[i];
        }
    }

    return operations;
}