#define MOD 1000000007

int numWays(char **words, int wordsSize, char *target) {
    int targetLen = strlen(target);
    int wordLen = strlen(words[0]);
    long long dp[targetLen + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    long long count[26] = {0};

    for (int i = 0; i < wordLen; i++) {
        for (int j = 0; j < wordsSize; j++) {
            count[words[j][i] - 'a']++;
        }
        for (int j = targetLen; j > 0; j--) {
            dp[j] = (dp[j] + dp[j - 1] * count[target[j - 1] - 'a']) % MOD;
        }
        memset(count, 0, sizeof(count));
    }

    return dp[targetLen];
}