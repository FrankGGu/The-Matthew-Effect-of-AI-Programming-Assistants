int maximumSum(int* arr, int arrSize, int k) {
    int maxSum = 0, minSum = 0;
    int currentMax = 0, currentMin = 0;
    int maxKSum = 0, minKSum = 0;

    for (int i = 0; i < arrSize; i++) {
        currentMax += arr[i];
        currentMin += arr[i];

        if (i >= k) {
            currentMax -= arr[i - k];
            currentMin -= arr[i - k];
        }

        if (i >= k - 1) {
            if (currentMax > maxKSum) {
                maxKSum = currentMax;
            }
            if (currentMin < minKSum || minKSum == 0) {
                minKSum = currentMin;
            }
        }
    }

    return maxKSum - minKSum;
}