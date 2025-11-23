bool canBeSorted(int* arr, int arrSize) {
    int min = arr[0], max = arr[0];
    for (int i = 1; i < arrSize; i++) {
        if (arr[i] < min) min = arr[i];
        if (arr[i] > max) max = arr[i];
    }

    int* count = (int*)calloc(max - min + 1, sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        count[arr[i] - min]++;
    }

    int index = 0;
    for (int i = 0; i <= max - min; i++) {
        while (count[i] > 0) {
            arr[index++] = i + min;
            count[i]--;
        }
    }

    free(count);
    for (int i = 1; i < arrSize; i++) {
        if (arr[i] < arr[i - 1]) {
            return false;
        }
    }
    return true;
}