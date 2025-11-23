int sumOfPower(int* nums, int numsSize, int k) {
    int MOD = 1000000007;
    long long dp[numsSize + 1][k + 1];

    for (int i = 0; i <= numsSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }
    dp[0][0] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = k; j >= 0; j--) {
            for (int count = numsSize; count >= 0; count--) {
                if (dp[count][j] == 0) continue;
                int newSum = j + nums[i];
                if (newSum <= k) {
                    dp[count + 1][newSum] = (dp[count + 1][newSum] + dp[count][j]) % MOD;
                }
            }
        }
    }

    long long result = 0;
    long long pow2[numsSize + 1];
    pow2[0] = 1;
    for (int i = 1; i <= numsSize; i++) {
        pow2[i] = (pow2[i - 1] * 2) % MOD;
    }

    for (int count = 1; count <= numsSize; count++) {
        if (dp[count][k] != 0) {
            result = (result + dp[count][k] * pow2[numsSize - count]) % MOD;
        }
    }

    return result;
}