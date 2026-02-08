int* transformArray(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    *returnSize = arrSize;

    for (int i = 0; i < arrSize; i++) {
        result[i] = arr[i];
    }

    for (int i = 1; i < arrSize - 1; i++) {
        if (arr[i] % 2 == 0 && arr[i - 1] < arr[i] && arr[i + 1] < arr[i]) {
            result[i]--;
        } else if (arr[i] % 2 == 1 && arr[i - 1] > arr[i] && arr[i + 1] > arr[i]) {
            result[i]++;
        }
    }

    return result;
}