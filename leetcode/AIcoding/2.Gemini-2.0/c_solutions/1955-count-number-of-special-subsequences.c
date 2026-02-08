#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSpecialSubsequences(int* nums, int numsSize) {
    long long dp0 = 0, dp1 = 0, dp2 = 0;
    int mod = 1e9 + 7;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            dp0 = (2 * dp0 + 1) % mod;
        } else if (nums[i] == 1) {
            dp1 = (2 * dp1 + dp0) % mod;
        } else {
            dp2 = (2 * dp2 + dp1) % mod;
        }
    }

    return dp2;
}