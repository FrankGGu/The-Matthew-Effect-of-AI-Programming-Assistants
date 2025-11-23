#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int beautifulSubarrays(int* nums, int numsSize) {
    int count = 0;
    int prefixXor = 0;
    int freq[1 << 20];
    for (int i = 0; i < (1 << 20); i++) {
        freq[i] = 0;
    }
    freq[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        prefixXor ^= nums[i];
        count += freq[prefixXor];
        freq[prefixXor]++;
    }

    return count;
}