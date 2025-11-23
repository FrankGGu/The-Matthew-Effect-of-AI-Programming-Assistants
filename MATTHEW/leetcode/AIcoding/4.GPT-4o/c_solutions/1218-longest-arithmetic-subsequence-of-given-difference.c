int longestSubsequence(int* arr, int arrSize, int difference) {
    int dp[10000] = {0};
    int maxLength = 0;

    for (int i = 0; i < arrSize; i++) {
        if (arr[i] - difference >= -10000 && arr[i] - difference <= 10000) {
            dp[arr[i] + 10000] = dp[arr[i] - difference + 10000] + 1;
        } else {
            dp[arr[i] + 10000] = 1;
        }
        if (dp[arr[i] + 10000] > maxLength) {
            maxLength = dp[arr[i] + 10000];
        }
    }

    return maxLength;
}