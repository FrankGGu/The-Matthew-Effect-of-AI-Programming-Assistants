int findSpecialInteger(int* arr, int arrSize) {
    int threshold = arrSize / 4;
    for (int i = 0; i < arrSize; i++) {
        if (i > 0 && arr[i] == arr[i - 1]) continue;
        int count = 1;
        while (i + 1 < arrSize && arr[i] == arr[i + 1]) {
            count++;
            i++;
        }
        if (count > threshold) {
            return arr[i];
        }
    }
    return -1;
}