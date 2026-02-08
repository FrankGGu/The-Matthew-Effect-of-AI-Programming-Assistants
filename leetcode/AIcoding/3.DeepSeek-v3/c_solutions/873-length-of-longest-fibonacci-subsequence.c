int lenLongestFibSubseq(int* arr, int arrSize) {
    int maxLen = 0;
    int dp[arrSize][arrSize];

    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < arrSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 2; i < arrSize; i++) {
        int left = 0, right = i - 1;
        while (left < right) {
            int sum = arr[left] + arr[right];
            if (sum > arr[i]) {
                right--;
            } else if (sum < arr[i]) {
                left++;
            } else {
                dp[right][i] = dp[left][right] + 1;
                if (dp[right][i] > maxLen) {
                    maxLen = dp[right][i];
                }
                left++;
                right--;
            }
        }
    }

    return maxLen == 0 ? 0 : maxLen + 2;
}