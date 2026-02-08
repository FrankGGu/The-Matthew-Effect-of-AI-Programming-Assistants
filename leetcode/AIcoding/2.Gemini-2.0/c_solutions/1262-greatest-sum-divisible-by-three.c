#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSumDivThree(int* nums, int numsSize) {
    int dp[3] = {0, -1, -1};
    for (int i = 0; i < numsSize; i++) {
        int a = dp[0], b = dp[1], c = dp[2];
        int num = nums[i];
        int rem = num % 3;
        if (rem == 0) {
            if (a != -1) dp[0] = a + num;
            if (b != -1) dp[1] = b + num;
            if (c != -1) dp[2] = c + num;
        } else if (rem == 1) {
            if (a != -1) dp[1] = fmax(dp[1], a + num);
            if (b != -1) dp[2] = fmax(dp[2], b + num);
            if (c != -1) dp[0] = fmax(dp[0], c + num);
        } else {
            if (a != -1) dp[2] = fmax(dp[2], a + num);
            if (b != -1) dp[0] = fmax(dp[0], b + num);
            if (c != -1) dp[1] = fmax(dp[1], c + num);
        }
    }
    return dp[0];
}