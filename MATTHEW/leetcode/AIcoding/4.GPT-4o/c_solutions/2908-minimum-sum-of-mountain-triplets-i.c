int minimumSum(int* arr, int arrSize) {
    if (arrSize < 3) return 0;
    int minSum = INT_MAX;

    for (int i = 0; i < arrSize - 2; i++) {
        for (int j = i + 1; j < arrSize - 1; j++) {
            for (int k = j + 1; k < arrSize; k++) {
                if (arr[i] < arr[j] && arr[j] > arr[k]) {
                    int currentSum = arr[i] + arr[j] + arr[k];
                    if (currentSum < minSum) {
                        minSum = currentSum;
                    }
                }
            }
        }
    }

    return minSum == INT_MAX ? 0 : minSum;
}