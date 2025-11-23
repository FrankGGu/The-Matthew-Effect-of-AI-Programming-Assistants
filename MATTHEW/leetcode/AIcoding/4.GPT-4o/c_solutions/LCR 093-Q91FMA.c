int lenLongestFibSubseq(int* A, int ASize) {
    int dp[1000][1000] = {0};
    int index[1000] = {0};
    int maxLength = 0;

    for (int i = 0; i < ASize; i++) {
        index[A[i]] = i + 1;
    }

    for (int j = 0; j < ASize; j++) {
        for (int k = j + 1; k < ASize; k++) {
            int i = A[k] - A[j];
            if (i < A[k] && index[i]) {
                dp[j][k] = dp[index[i] - 1][j] + 1;
                maxLength = fmax(maxLength, dp[j][k] + 2);
            }
        }
    }

    return maxLength >= 3 ? maxLength : 0;
}