int sumOddLengthSubarrays(int* arr, int arrSize) {
    int totalSum = 0;
    for (int length = 1; length <= arrSize; length += 2) {
        for (int start = 0; start <= arrSize - length; start++) {
            for (int i = start; i < start + length; i++) {
                totalSum += arr[i];
            }
        }
    }
    return totalSum;
}