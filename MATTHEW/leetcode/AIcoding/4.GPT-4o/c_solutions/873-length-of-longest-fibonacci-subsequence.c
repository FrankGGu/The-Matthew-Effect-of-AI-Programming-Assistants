int lenLongestFibSubseq(int* A, int ASize) {
    int dp[1000][1000] = {0};
    int maxLength = 0;
    int index[1000] = {0};
    for (int i = 0; i < ASize; i++) {
        index[A[i]] = i;
    }

    for (int j = 1; j < ASize; j++) {
        for (int i = 0; i < j; i++) {
            int k = A[j] - A[i];
            if (k < A[i] && index[k] < i) {
                dp[i][j] = dp[index[k]][i] + 1;
                maxLength = fmax(maxLength, dp[i][j] + 2);
            }
        }
    }

    return maxLength >= 3 ? maxLength : 0;
}