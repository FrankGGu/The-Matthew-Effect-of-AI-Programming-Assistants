int variableLengthSubsetSum(int* arr, int arrSize) {
    int totalSum = 0;
    for (int i = 0; i < arrSize; i++) {
        for (int j = i; j < arrSize; j++) {
            for (int k = i; k <= j; k++) {
                totalSum += arr[k];
            }
        }
    }
    return totalSum;
}