#include <stddef.h>

int countMaxOrSubsets(int* nums, int numsSize) {
    int max_or_val = 0;
    for (int i = 0; i < numsSize; i++) {
        max_or_val |= nums[i];
    }

    int count = 0;
    for (int i = 0; i < (1 << numsSize); i++) {
        int current_or_val = 0;
        for (int j = 0; j < numsSize; j++) {
            if ((i >> j) & 1) {
                current_or_val |= nums[j];
            }
        }
        if (current_or_val == max_or_val) {
            count++;
        }
    }

    return count;
}