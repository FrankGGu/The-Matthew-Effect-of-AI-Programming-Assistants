int findSpecialInteger(int* arr, int arrSize) {
    int threshold = arrSize / 4;
    for (int i = 0; i < arrSize - threshold; i++) {
        if (arr[i] == arr[i + threshold]) {
            return arr[i];
        }
    }
    return -1;
}