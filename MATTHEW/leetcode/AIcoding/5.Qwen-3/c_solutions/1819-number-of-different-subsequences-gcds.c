#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int subseqGCD(int* nums, int numsSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    int* dp = (int*)calloc(maxNum + 1, sizeof(int));
    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        for (int j = 1; j <= maxNum; ++j) {
            if (dp[j] != 0) {
                int g = __gcd(j, num);
                if (dp[g] == 0) {
                    dp[g] = 1;
                }
            }
        }
        if (dp[num] == 0) {
            dp[num] = 1;
        }
    }

    int count = 0;
    for (int i = 1; i <= maxNum; ++i) {
        if (dp[i] == 1) {
            ++count;
        }
    }

    free(dp);
    return count;
}