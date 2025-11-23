int maxStrength(int* nums, int numsSize, int k){
    int dp[k + 1][numsSize + 1];
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j <= numsSize; j++) {
            dp[i][j] = (i == 0) ? 1 : (j == 0) ? 0 : INT_MIN;
        }
    }

    for (int i = 1; i <= k; i++) {
        for (int j = 1; j <= numsSize; j++) {
            for (int l = 0; l < j; l++) {
                int product = 1;
                for (int m = l; m < j; m++) {
                    product *= nums[m];
                }
                dp[i][j] = fmax(dp[i][j], dp[i - 1][l] * product);
            }
        }
    }

    return dp[k][numsSize];
}