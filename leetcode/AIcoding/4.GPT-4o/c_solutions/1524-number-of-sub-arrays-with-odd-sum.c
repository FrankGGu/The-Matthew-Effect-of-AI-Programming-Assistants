int numOfSubarrays(int* arr, int arrSize) {
    int oddCount = 0, evenCount = 1, sum = 0, result = 0;

    for (int i = 0; i < arrSize; i++) {
        sum += arr[i];
        if (sum % 2 == 0) {
            result += oddCount;
            evenCount++;
        } else {
            result += evenCount;
            oddCount++;
        }
    }

    return result;
}