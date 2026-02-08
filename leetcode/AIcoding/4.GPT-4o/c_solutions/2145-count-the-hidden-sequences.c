int countHiddenSequences(int* arr, int arrSize, int difference) {
    int dp[1000] = {0};
    int count = 0;

    for (int i = 0; i < arrSize; i++) {
        dp[arr[i] + 500] = dp[arr[i] + 500 - difference] + 1;
        count += dp[arr[i] + 500];
    }

    return count;
}