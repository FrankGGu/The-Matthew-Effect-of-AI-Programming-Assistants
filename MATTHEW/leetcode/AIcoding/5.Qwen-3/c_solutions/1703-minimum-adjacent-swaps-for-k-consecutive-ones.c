#include <stdio.h>
#include <stdlib.h>

int minAdjacentSwapsForKConsecutiveOnes(int* nums, int numsSize, int k) {
    int n = numsSize;
    int* pos = (int*)malloc(n * sizeof(int));
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (nums[i] == 1) {
            pos[count++] = i;
        }
    }

    int res = 0;
    for (int i = 0; i < count - k + 1; i++) {
        int mid = i + k / 2;
        int median = pos[mid];
        int swaps = 0;
        for (int j = i; j <= i + k - 1; j++) {
            swaps += abs(pos[j] - median);
        }
        res = (res == 0 || swaps < res) ? swaps : res;
    }

    free(pos);
    return res;
}