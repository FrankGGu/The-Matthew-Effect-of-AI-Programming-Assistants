bool hasAdjacentIncreasingSubarrays(int* arr, int arrSize) {
    for (int i = 1; i < arrSize; i++) {
        if (arr[i] > arr[i-1] && i > 1 && arr[i-1] > arr[i-2]) {
            return true;
        }
    }
    return false;
}