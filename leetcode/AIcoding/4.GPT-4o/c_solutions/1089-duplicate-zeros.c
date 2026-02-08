void duplicateZeros(int* arr, int arrSize) {
    int count = 0, i;

    for (i = 0; i < arrSize; i++) {
        if (arr[i] == 0) count++;
    }

    for (i = arrSize - 1; i >= 0; i--) {
        if (i + count < arrSize) {
            arr[i + count] = arr[i];
        }
        if (arr[i] == 0) {
            count--;
            if (i + count < arrSize) {
                arr[i + count] = 0;
            }
        }
    }
}