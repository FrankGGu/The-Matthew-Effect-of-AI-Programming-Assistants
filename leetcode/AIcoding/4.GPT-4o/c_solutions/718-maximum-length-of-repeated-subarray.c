int findLength(int* A, int ASize, int* B, int BSize) {
    int dp[1001][1001] = {0};
    int maxLength = 0;

    for (int i = 1; i <= ASize; i++) {
        for (int j = 1; j <= BSize; j++) {
            if (A[i - 1] == B[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
                if (dp[i][j] > maxLength) {
                    maxLength = dp[i][j];
                }
            }
        }
    }

    return maxLength;
}