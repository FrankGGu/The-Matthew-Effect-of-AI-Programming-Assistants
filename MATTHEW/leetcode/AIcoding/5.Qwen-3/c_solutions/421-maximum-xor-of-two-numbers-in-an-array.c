#include <stdio.h>
#include <stdlib.h>

int maxSubArraySum(int* nums, int numsSize) {
    int max_so_far = -2147483648;
    int max_ending_here = 0;

    for (int i = 0; i < numsSize; i++) {
        max_ending_here = max_ending_here + nums[i];
        if (max_so_far < max_ending_here)
            max_so_far = max_ending_here;
        if (max_ending_here < 0)
            max_ending_here = 0;
    }
    return max_so_far;
}

int findMaximumXOR(int* nums, int numsSize) {
    int max_xor = 0;
    int mask = 0;

    for (int i = 31; i >= 0; i--) {
        mask = mask | (1 << i);
        int tmp = max_xor | (1 << i);
        int prefix = 0;
        int hash[1024] = {0};

        for (int j = 0; j < numsSize; j++) {
            prefix = nums[j] & mask;
            hash[prefix] = 1;
        }

        for (int j = 0; j < numsSize; j++) {
            prefix = nums[j] & mask;
            if (hash[tmp ^ prefix]) {
                max_xor = tmp;
                break;
            }
        }
    }

    return max_xor;
}