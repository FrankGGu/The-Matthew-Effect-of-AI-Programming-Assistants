int maximumSum(int* arr, int arrSize) {
    int maxSum = arr[0];
    int maxEndingHere = arr[0];
    int maxEndingHereWithDelete = 0;

    for (int i = 1; i < arrSize; i++) {
        maxEndingHere = fmax(arr[i], maxEndingHere + arr[i]);
        maxEndingHereWithDelete = fmax(maxEndingHereWithDelete + arr[i], maxEndingHere);
        maxSum = fmax(maxSum, fmax(maxEndingHere, maxEndingHereWithDelete));
    }

    return maxSum;
}