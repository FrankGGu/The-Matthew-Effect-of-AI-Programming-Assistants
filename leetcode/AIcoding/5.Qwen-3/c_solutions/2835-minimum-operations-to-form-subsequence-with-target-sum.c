#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize, int target) {
    if (target == 0) return 0;
    int operations = 0;
    int bit = 0;
    while (target > 0) {
        int count = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] & (1 << bit)) {
                count++;
            }
        }
        if (count > 0) {
            if (target & (1 << bit)) {
                target -= (1 << bit);
            } else {
                operations += 1;
            }
        } else {
            operations += 1;
        }
        bit++;
        target >>= 1;
    }
    return operations;
}