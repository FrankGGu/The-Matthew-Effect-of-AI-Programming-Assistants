#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumStrongPairXor(int* nums, int numsSize) {
    int max_xor = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (abs(nums[i] - nums[j]) <= (nums[i] > nums[j] ? nums[i] : nums[j])) {
                int xor_val = nums[i] ^ nums[j];
                if (xor_val > max_xor) {
                    max_xor = xor_val;
                }
            }
        }
    }
    return max_xor;
}