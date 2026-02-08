#include <stddef.h>
#include <stdlib.h> // For llabs

long long minOperations(int* nums, int numsSize, int k) {
    long long operations = 0;
    long long current_suffix_effect = 0;

    for (int i = numsSize - 1; i >= 0; --i) {
        long long effective_val_at_i = (long long)nums[i] + current_suffix_effect;
        long long diff = k - effective_val_at_i;

        operations += llabs(diff);
        current_suffix_effect += diff;
    }

    return operations;
}