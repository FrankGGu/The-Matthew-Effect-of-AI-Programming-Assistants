int lenLongestFibSubseq(int* arr, int arrSize) {
    int maxLen = 0;
    int dp[arrSize][arrSize];

    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < arrSize; j++) {
            dp[i][j] = 2;
        }
    }

    for (int j = 2; j < arrSize; j++) {
        int left = 0, right = j - 1;
        while (left < right) {
            int sum = arr[left] + arr[right];
            if (sum == arr[j]) {
                dp[right][j] = dp[left][right] + 1;
                if (dp[right][j] > maxLen) {
                    maxLen = dp[right][j];
                }
                left++;
                right--;
            } else if (sum < arr[j]) {
                left++;
            } else {
                right--;
            }
        }
    }

    return maxLen;
}