#include <stdio.h>
#include <stdlib.h>

int maximumSet(int* nums, int numsSize, int k) {
    int* freq = (int*)calloc(10001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int res = 0;
    for (int i = 0; i <= 10000; i++) {
        if (freq[i] > 0) {
            res++;
            if (i + k <= 10000) {
                freq[i + k]--;
            }
        }
    }

    free(freq);
    return res;
}