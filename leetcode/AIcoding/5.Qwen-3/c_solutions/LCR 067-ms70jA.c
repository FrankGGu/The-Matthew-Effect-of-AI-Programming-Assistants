#include <stdio.h>
#include <stdlib.h>

int findMaximumXOR(int* nums, int numsSize) {
    int max_xor = 0;
    int mask = 0;
    for (int i = 31; i >= 0; --i) {
        mask = mask | (1 << i);
        int tmp = max_xor | (1 << i);
        int prefix = 0;
        int hash[1024] = {0};
        for (int j = 0; j < numsSize; ++j) {
            prefix = nums[j] & mask;
            if (hash[prefix ^ tmp]) {
                max_xor = tmp;
                break;
            }
            hash[prefix] = 1;
        }
    }
    return max_xor;
}