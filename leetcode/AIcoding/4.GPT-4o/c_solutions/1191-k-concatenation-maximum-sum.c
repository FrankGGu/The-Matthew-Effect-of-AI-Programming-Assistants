int kConcatenationMaxSum(int* arr, int arrSize, int k) {
    long long mod = 1000000007;
    long long totalSum = 0, maxSum = 0, currentSum = 0, maxPrefix = 0, maxSuffix = 0;

    for (int i = 0; i < arrSize; i++) {
        totalSum = (totalSum + arr[i]) % mod;
        currentSum = (currentSum + arr[i]) % mod;
        if (currentSum < 0) currentSum = 0;
        if (currentSum > maxSum) maxSum = currentSum;
    }

    currentSum = 0;
    for (int i = 0; i < arrSize; i++) {
        currentSum = (currentSum + arr[i]) % mod;
        if (i == 0) maxPrefix = currentSum;
        if (currentSum > maxPrefix) maxPrefix = currentSum;
    }

    currentSum = 0;
    for (int i = arrSize - 1; i >= 0; i--) {
        currentSum = (currentSum + arr[i]) % mod;
        if (i == arrSize - 1) maxSuffix = currentSum;
        if (currentSum > maxSuffix) maxSuffix = currentSum;
    }

    if (k == 1) return maxSum;

    long long result = (maxSuffix + maxPrefix + (totalSum * (k - 2)) % mod) % mod;
    if (totalSum > 0) result = (result + totalSum) % mod;

    return result > 0 ? result : 0;
}