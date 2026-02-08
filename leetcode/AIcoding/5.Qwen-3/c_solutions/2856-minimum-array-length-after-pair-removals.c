#include <stdio.h>
#include <stdlib.h>

int minArrayLength(int* nums, int numsSize) {
    int* freq = (int*)calloc(10001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int res = numsSize;
    for (int i = 1; i <= 10000; i++) {
        if (freq[i] > 0) {
            int pairs = freq[i] / 2;
            res -= pairs;
            if (pairs > 0) {
                freq[i + 1] = 0;
            }
        }
    }

    free(freq);
    return res;
}