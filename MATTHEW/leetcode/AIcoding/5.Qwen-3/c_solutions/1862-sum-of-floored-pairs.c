#include <stdio.h>
#include <stdlib.h>

int sumOfFlooredPairs(int* nums, int numsSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    int* freq = (int*)calloc(maxNum + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int MOD = 1000000007;
    long long result = 0;

    for (int x = 1; x <= maxNum; x++) {
        if (freq[x] == 0) continue;
        for (int k = 1; k * x <= maxNum; k++) {
            int lower = k * x;
            int upper = (k + 1) * x - 1;
            int count = 0;
            for (int y = lower; y <= upper && y <= maxNum; y++) {
                count += freq[y];
            }
            result = (result + (long long)freq[x] * count) % MOD;
        }
    }

    free(freq);
    return (int)result;
}