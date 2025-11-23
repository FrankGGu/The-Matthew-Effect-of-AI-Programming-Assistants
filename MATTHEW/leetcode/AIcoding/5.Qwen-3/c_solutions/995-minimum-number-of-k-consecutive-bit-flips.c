#include <stdio.h>
#include <stdlib.h>

int minKBitFlipping(int* nums, int numsSize, int k) {
    int n = numsSize;
    int* flip = (int*)calloc(n, sizeof(int));
    int currentFlip = 0;
    int result = 0;

    for (int i = 0; i < n; ++i) {
        currentFlip += flip[i];
        if (nums[i] + currentFlip % 2 == 1) {
            continue;
        }
        if (i + k > n) {
            return -1;
        }
        currentFlip++;
        result++;
        if (i + k < n) {
            flip[i + k]--;
        }
    }

    free(flip);
    return result;
}