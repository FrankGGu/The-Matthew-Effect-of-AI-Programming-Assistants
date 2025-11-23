int longestArithSeqLength(int* A, int ASize) {
    if (ASize <= 2) return ASize;
    int dp[1000][2001] = {0};
    int maxLength = 2;

    for (int i = 0; i < ASize; i++) {
        for (int j = 0; j < i; j++) {
            int diff = A[i] - A[j] + 1000; // offset to handle negative differences
            dp[i][diff] = dp[j][diff] + 1;
            maxLength = fmax(maxLength, dp[i][diff] + 1);
        }
    }
    return maxLength;
}