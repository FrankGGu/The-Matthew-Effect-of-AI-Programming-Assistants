#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxStrength(int* nums, int numsSize, int k) {
    int dp[numsSize + 1][k + 1];

    for (int i = 0; i <= numsSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= numsSize; i++) {
        for (int j = 1; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            int product = 1;
            for (int l = i; l >= 1; l--) {
                product *= nums[l - 1];
                if (j == 1) {
                    if(product > dp[i][j])
                        dp[i][j] = product;
                }
                else if (l > 1) {
                    if((long long)dp[l - 1][j - 1] * product > dp[i][j])
                        dp[i][j] = dp[l - 1][j - 1] * product;
                }
                else {
                    if(product > dp[i][j])
                        dp[i][j] = product;
                }
            }
        }
    }

    return dp[numsSize][k];
}