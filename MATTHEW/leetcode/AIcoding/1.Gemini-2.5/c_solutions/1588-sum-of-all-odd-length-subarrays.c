int sumOddLengthSubarrays(int* arr, int arrSize) {
    int totalSum = 0;
    for (int i = 0; i < arrSize; i++) {
        int leftCount = i + 1;
        int rightCount = arrSize - i;
        int numSubarrays = (leftCount * rightCount + 1) / 2;
        totalSum += numSubarrays * arr[i];
    }
    return totalSum;
}