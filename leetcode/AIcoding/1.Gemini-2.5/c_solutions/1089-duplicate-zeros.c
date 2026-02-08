void duplicateZeros(int* arr, int arrSize) {
    int i = 0;
    int j = 0;

    for (i = 0; i < arrSize; i++) {
        if (arr[i] == 0) {
            j++;
        }
    }

    j = arrSize + j - 1;
    i = arrSize - 1;

    while (i >= 0) {
        if (j < arrSize) {
            arr[j] = arr[i];
        }
        j--;

        if (arr[i] == 0) {
            if (j < arrSize) {
                arr[j] = 0;
            }
            j--;
        }
        i--;
    }
}