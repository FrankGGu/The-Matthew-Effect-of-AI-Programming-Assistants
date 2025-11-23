#include <stdio.h>
#include <stdlib.h>

int numberOfExcellentPairs(long long* nums, int numsSize) {
    int count[64] = {0};
    for (int i = 0; i < numsSize; i++) {
        long long x = nums[i];
        int bits = 0;
        while (x > 0) {
            bits++;
            x >>= 1;
        }
        count[bits]++;
    }

    long long res = 0;
    for (int i = 1; i <= 63; i++) {
        for (int j = 1; j <= 63; j++) {
            if (i + j <= 64) {
                res += (long long)count[i] * count[j];
            }
        }
    }
    return res;
}