int longestSubsequence(int* arr, int arrSize, int* difference, int differencesSize) {
    int dp[200001] = {0};
    int offset = 100000;
    int max_len = 1;

    for (int i = 0; i < arrSize; i++) {
        int prev = arr[i] - difference[0];
        if (prev >= -100000 && prev <= 100000) {
            dp[arr[i] + offset] = dp[prev + offset] + 1;
        } else {
            dp[arr[i] + offset] = 1;
        }
        if (dp[arr[i] + offset] > max_len) {
            max_len = dp[arr[i] + offset];
        }
    }

    return max_len;
}