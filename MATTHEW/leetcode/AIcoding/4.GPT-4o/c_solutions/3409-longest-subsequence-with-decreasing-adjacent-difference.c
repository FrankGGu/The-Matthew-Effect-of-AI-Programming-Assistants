int longestSubsequence(int* arr, int arrSize, int difference) {
    int dp[1000] = {0};
    int maxLength = 0;

    for (int i = 0; i < arrSize; i++) {
        dp[i] = 1; // Each element is a subsequence of length 1
        for (int j = 0; j < i; j++) {
            if (arr[i] - arr[j] == difference) {
                dp[i] = dp[j] + 1 > dp[i] ? dp[j] + 1 : dp[i];
            }
        }
        maxLength = maxLength > dp[i] ? maxLength : dp[i];
    }

    return maxLength;
}