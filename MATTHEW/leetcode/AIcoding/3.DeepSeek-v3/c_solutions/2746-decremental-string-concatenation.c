int minimizeConcatenatedLength(char** words, int wordsSize) {
    int dp[1000][26][26];
    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < 26; j++) {
            for (int k = 0; k < 26; k++) {
                dp[i][j][k] = 1000000000;
            }
        }
    }

    char* first = words[0];
    int len = strlen(first);
    int start = first[0] - 'a';
    int end = first[len - 1] - 'a';
    dp[0][start][end] = len;

    for (int i = 1; i < wordsSize; i++) {
        char* word = words[i];
        int wordLen = strlen(word);
        int s = word[0] - 'a';
        int e = word[wordLen - 1] - 'a';

        for (int j = 0; j < 26; j++) {
            for (int k = 0; k < 26; k++) {
                if (dp[i-1][j][k] == 1000000000) continue;

                int current = dp[i-1][j][k] + wordLen;
                if (k == s) current--;
                dp[i][j][e] = (dp[i][j][e] < current) ? dp[i][j][e] : current;

                current = dp[i-1][j][k] + wordLen;
                if (e == j) current--;
                dp[i][s][k] = (dp[i][s][k] < current) ? dp[i][s][k] : current;
            }
        }
    }

    int ans = 1000000000;
    for (int j = 0; j < 26; j++) {
        for (int k = 0; k < 26; k++) {
            if (dp[wordsSize-1][j][k] < ans) {
                ans = dp[wordsSize-1][j][k];
            }
        }
    }
    return ans;
}