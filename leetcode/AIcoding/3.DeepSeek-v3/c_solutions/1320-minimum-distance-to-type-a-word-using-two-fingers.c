int minDistance(char* word) {
    int n = strlen(word);
    if (n <= 1) return 0;

    int dp[n][26][26];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < 26; j++) {
            for (int k = 0; k < 26; k++) {
                dp[i][j][k] = 1000000;
            }
        }
    }

    int first = word[0] - 'A';
    for (int i = 0; i < 26; i++) {
        dp[0][first][i] = 0;
        dp[0][i][first] = 0;
    }

    for (int i = 1; i < n; i++) {
        int curr = word[i] - 'A';
        int prev = word[i-1] - 'A';

        for (int j = 0; j < 26; j++) {
            for (int k = 0; k < 26; k++) {
                if (dp[i-1][j][k] != 1000000) {
                    int cost1 = dist(j, curr);
                    int cost2 = dist(k, curr);

                    dp[i][curr][k] = fmin(dp[i][curr][k], dp[i-1][j][k] + cost1);
                    dp[i][j][curr] = fmin(dp[i][j][curr], dp[i-1][j][k] + cost2);
                }
            }
        }
    }

    int res = 1000000;
    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            res = fmin(res, dp[n-1][i][j]);
        }
    }
    return res;
}

int dist(int a, int b) {
    int x1 = a / 6, y1 = a % 6;
    int x2 = b / 6, y2 = b % 6;
    return abs(x1 - x2) + abs(y1 - y2);
}