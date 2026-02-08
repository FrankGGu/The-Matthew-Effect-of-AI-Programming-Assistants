/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* stableArrays(int zero, int one, int limit, int* returnSize) {
    int mod = 1000000007;
    int dp[201][201][2];
    for (int i = 0; i <= zero; i++) {
        for (int j = 0; j <= one; j++) {
            dp[i][j][0] = 0;
            dp[i][j][1] = 0;
        }
    }

    if (zero > 0) dp[1][0][0] = 1;
    if (one > 0) dp[0][1][1] = 1;

    for (int i = 0; i <= zero; i++) {
        for (int j = 0; j <= one; j++) {
            if (i == 0 && j == 0) continue;

            if (i > 0) {
                if (i > 1) dp[i][j][0] = (dp[i][j][0] + dp[i-1][j][0]) % mod;
                if (i > limit) dp[i][j][0] = (dp[i][j][0] - dp[i-limit-1][j][1] + mod) % mod;
                dp[i][j][0] = (dp[i][j][0] + dp[i-1][j][1]) % mod;
            }

            if (j > 0) {
                if (j > 1) dp[i][j][1] = (dp[i][j][1] + dp[i][j-1][1]) % mod;
                if (j > limit) dp[i][j][1] = (dp[i][j][1] - dp[i][j-limit-1][0] + mod) % mod;
                dp[i][j][1] = (dp[i][j][1] + dp[i][j-1][0]) % mod;
            }
        }
    }

    int* result = (int*)malloc(sizeof(int));
    *result = (dp[zero][one][0] + dp[zero][one][1]) % mod;
    *returnSize = 1;
    return result;
}