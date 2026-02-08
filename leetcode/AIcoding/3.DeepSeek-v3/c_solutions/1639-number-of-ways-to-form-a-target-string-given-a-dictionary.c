typedef long long ll;

int numWays(char** words, int wordsSize, char* target) {
    int wordLen = strlen(words[0]);
    int targetLen = strlen(target);
    int mod = 1000000007;

    if (targetLen > wordLen) return 0;

    ll** freq = (ll**)malloc(wordLen * sizeof(ll*));
    for (int i = 0; i < wordLen; i++) {
        freq[i] = (ll*)calloc(26, sizeof(ll));
    }

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < wordLen; j++) {
            freq[j][words[i][j] - 'a']++;
        }
    }

    ll** dp = (ll**)malloc((targetLen + 1) * sizeof(ll*));
    for (int i = 0; i <= targetLen; i++) {
        dp[i] = (ll*)calloc(wordLen + 1, sizeof(ll));
    }

    for (int j = 0; j <= wordLen; j++) {
        dp[0][j] = 1;
    }

    for (int i = 1; i <= targetLen; i++) {
        for (int j = 1; j <= wordLen; j++) {
            dp[i][j] = dp[i][j - 1];
            if (freq[j - 1][target[i - 1] - 'a'] > 0) {
                dp[i][j] = (dp[i][j] + freq[j - 1][target[i - 1] - 'a'] * dp[i - 1][j - 1]) % mod;
            }
        }
    }

    int result = dp[targetLen][wordLen];

    for (int i = 0; i < wordLen; i++) {
        free(freq[i]);
    }
    free(freq);

    for (int i = 0; i <= targetLen; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}