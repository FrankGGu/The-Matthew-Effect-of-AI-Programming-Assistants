int sumOddLengthSubarrays(int* arr, int arrSize) {
    int sum = 0;
    for (int i = 0; i < arrSize; i++) {
        int total = (i + 1) * (arrSize - i);
        int odd = (total + 1) / 2;
        sum += arr[i] * odd;
    }
    return sum;
}