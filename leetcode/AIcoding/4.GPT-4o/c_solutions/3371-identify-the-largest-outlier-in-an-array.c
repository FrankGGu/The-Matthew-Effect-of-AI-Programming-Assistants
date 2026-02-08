int largestOutlier(int* arr, int arrSize) {
    int oddCount = 0, evenCount = 0, oddIndex = -1, evenIndex = -1;

    for (int i = 0; i < arrSize; i++) {
        if (arr[i] % 2 == 0) {
            evenCount++;
            evenIndex = i;
        } else {
            oddCount++;
            oddIndex = i;
        }
    }

    if (oddCount == 1) {
        return arr[oddIndex];
    }

    return arr[evenIndex];
}