int* replaceElements(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    *returnSize = arrSize;

    if (arrSize == 0) {
        return result;
    }

    int max_right = -1;

    for (int i = arrSize - 1; i >= 0; i--) {
        result[i] = max_right;
        if (arr[i] > max_right) {
            max_right = arr[i];
        }
    }

    return result;
}