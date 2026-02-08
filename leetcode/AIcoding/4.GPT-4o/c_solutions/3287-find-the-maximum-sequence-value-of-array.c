int maxSequenceValue(int* arr, int arrSize) {
    int maxSum = 0, currentSum = 0;
    for (int i = 0; i < arrSize; i++) {
        currentSum += arr[i];
        if (currentSum < 0) {
            currentSum = 0;
        }
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }
    return maxSum;
}