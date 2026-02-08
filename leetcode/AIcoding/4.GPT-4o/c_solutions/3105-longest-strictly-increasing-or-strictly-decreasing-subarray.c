int longestAlternatingSubarray(int* arr, int arrSize) {
    if (arrSize < 2) return arrSize;

    int maxLength = 1;
    int currentLength = 1;

    for (int i = 1; i < arrSize; i++) {
        if ((arr[i] > arr[i - 1] && (i == 1 || arr[i - 1] <= arr[i - 2])) || 
            (arr[i] < arr[i - 1] && (i == 1 || arr[i - 1] >= arr[i - 2]))) {
            currentLength++;
        } else {
            maxLength = fmax(maxLength, currentLength);
            currentLength = 2;
        }
    }
    return fmax(maxLength, currentLength);
}