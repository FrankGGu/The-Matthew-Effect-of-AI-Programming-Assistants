#define MOD 1000000007

int countWays(int** hats, int hatsSize, int* hatsColSize) {
    int maxHat = 40;
    int personCount = hatsSize;
    int dp[1 << personCount][maxHat + 1];
    memset(dp, 0, sizeof(dp));
    dp[0][0] = 1;

    for (int i = 0; i < personCount; ++i) {
        for (int j = 0; j < (1 << personCount); ++j) {
            for (int k = 0; k < hatsColSize[i]; ++k) {
                int hat = hats[i][k];
                if (!(j & (1 << i))) {
                    dp[j | (1 << i)][hat] = (dp[j | (1 << i)][hat] + dp[j][0]) % MOD;
                }
            }
        }
        for (int j = 0; j < (1 << personCount); ++j) {
            for (int k = 1; k <= maxHat; ++k) {
                dp[j][k] = (dp[j][k] + dp[j][0]) % MOD;
            }
        }
    }

    int result = 0;
    for (int i = 1; i < (1 << personCount); ++i) {
        result = (result + dp[i][0]) % MOD;
    }

    return result;
}