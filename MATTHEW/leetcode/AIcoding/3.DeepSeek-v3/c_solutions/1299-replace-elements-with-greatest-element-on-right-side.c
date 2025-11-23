int* replaceElements(int* arr, int arrSize, int* returnSize) {
    *returnSize = arrSize;
    if (arrSize == 1) {
        arr[0] = -1;
        return arr;
    }

    int maxSoFar = arr[arrSize - 1];
    arr[arrSize - 1] = -1;

    for (int i = arrSize - 2; i >= 0; i--) {
        int current = arr[i];
        arr[i] = maxSoFar;
        if (current > maxSoFar) {
            maxSoFar = current;
        }
    }

    return arr;
}