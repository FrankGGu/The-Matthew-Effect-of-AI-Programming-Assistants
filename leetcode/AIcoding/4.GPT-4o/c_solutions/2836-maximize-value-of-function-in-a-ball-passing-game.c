int maxValue(int* arr, int arrSize, int k) {
    int maxSum = 0;
    for (int i = 0; i < arrSize; i++) {
        maxSum += arr[i];
    }

    int currentSum = maxSum;
    for (int i = 0; i < arrSize; i++) {
        if (i < k) {
            currentSum -= arr[i];
        } else {
            currentSum -= arr[i];
            currentSum += arr[i - k];
        }
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    return maxSum;
}