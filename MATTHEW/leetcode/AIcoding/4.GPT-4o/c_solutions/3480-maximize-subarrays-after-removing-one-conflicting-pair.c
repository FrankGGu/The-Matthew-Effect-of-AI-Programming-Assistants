int maximumSum(int* arr, int arrSize) {
    int maxSum = arr[0], currentSum = arr[0], maxEndingHere = arr[0];
    for (int i = 1; i < arrSize; i++) {
        currentSum = (currentSum + arr[i] > arr[i]) ? currentSum + arr[i] : arr[i];
        maxEndingHere = (maxEndingHere + arr[i] > arr[i]) ? maxEndingHere + arr[i] : arr[i];
        maxSum = maxSum > currentSum ? maxSum : currentSum;
    }

    int leftMax[arrSize];
    int rightMax[arrSize];

    leftMax[0] = arr[0];
    for (int i = 1; i < arrSize; i++) {
        leftMax[i] = (leftMax[i - 1] + arr[i] > arr[i]) ? leftMax[i - 1] + arr[i] : arr[i];
    }

    rightMax[arrSize - 1] = arr[arrSize - 1];
    for (int i = arrSize - 2; i >= 0; i--) {
        rightMax[i] = (rightMax[i + 1] + arr[i] > arr[i]) ? rightMax[i + 1] + arr[i] : arr[i];
    }

    for (int i = 1; i < arrSize - 1; i++) {
        int sumWithoutPair = leftMax[i - 1] + rightMax[i + 1];
        maxSum = maxSum > sumWithoutPair ? maxSum : sumWithoutPair;
    }

    return maxSum;
}