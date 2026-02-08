#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minMoves(int* nums, int numsSize, int limit){
    int diff[2 * limit + 2];
    for (int i = 0; i <= 2 * limit + 1; i++) {
        diff[i] = 0;
    }

    for (int i = 0; i < numsSize / 2; i++) {
        int a = nums[i], b = nums[numsSize - 1 - i];
        int minVal = 1 + fmin(a, b);
        int maxVal = limit + fmax(a, b);
        diff[minVal] -= 1;
        diff[a + b] -= 1;
        diff[a + b + 1] += 1;
        diff[maxVal + 1] += 1;
    }

    int res = numsSize;
    int curr = 0;
    for (int i = 2; i <= 2 * limit; i++) {
        curr += diff[i];
        res = fmin(res, numsSize / 2 + curr);
    }

    return res;
}