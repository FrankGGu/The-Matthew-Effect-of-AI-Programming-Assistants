int minSumOfLengths(int* arr, int arrSize, int target) {
    int minLength = arrSize + 1, sum = 0, start = 0;
    int* dp = (int*)malloc(arrSize * sizeof(int));

    for (int end = 0; end < arrSize; end++) {
        sum += arr[end];
        while (sum > target) {
            sum -= arr[start++];
        }
        if (sum == target) {
            int length = end - start + 1;
            dp[end] = length;
            if (start > 0) {
                dp[end] = fmin(dp[end], dp[start - 1]);
            }
        } else {
            dp[end] = (end == 0) ? arrSize + 1 : dp[end - 1];
        }
    }

    sum = 0;
    start = 0;
    int result = arrSize + 1;

    for (int end = 0; end < arrSize; end++) {
        sum += arr[end];
        while (sum > target) {
            sum -= arr[start++];
        }
        if (sum == target) {
            int length = end - start + 1;
            if (start > 0 && dp[start - 1] < arrSize + 1) {
                result = fmin(result, length + dp[start - 1]);
            }
        }
    }

    free(dp);
    return result == arrSize + 1 ? -1 : result;
}