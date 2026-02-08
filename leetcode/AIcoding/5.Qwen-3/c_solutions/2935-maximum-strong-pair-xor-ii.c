#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maximumStrongPairXOR(int* nums, int numsSize) {
    int max_xor = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (abs(nums[i] - nums[j]) <= fmin(nums[i], nums[j])) {
                int current_xor = nums[i] ^ nums[j];
                if (current_xor > max_xor) {
                    max_xor = current_xor;
                }
            }
        }
    }
    return max_xor;
}