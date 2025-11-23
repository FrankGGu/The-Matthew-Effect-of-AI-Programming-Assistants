#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rev(int num) {
    int reversed = 0;
    while (num > 0) {
        reversed = reversed * 10 + num % 10;
        num /= 10;
    }
    return reversed;
}

int countNicePairs(int* nums, int numsSize) {
    int count = 0;
    int mod = 1000000007;
    int* diffs = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        diffs[i] = nums[i] - rev(nums[i]);
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (diffs[i] == diffs[j]) {
                count = (count + 1) % mod;
            }
        }
    }
    free(diffs);
    return count;
}