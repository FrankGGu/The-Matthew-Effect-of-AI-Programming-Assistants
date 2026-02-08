int* transformArray(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    *returnSize = arrSize;
    for (int i = 0; i < arrSize; i++) {
        result[i] = arr[i];
    }

    int changed;
    do {
        changed = 0;
        int* temp = (int*)malloc(arrSize * sizeof(int));
        for (int i = 0; i < arrSize; i++) {
            temp[i] = result[i];
        }

        for (int i = 1; i < arrSize - 1; i++) {
            if (temp[i] > temp[i - 1] && temp[i] > temp[i + 1]) {
                result[i] = temp[i] - 1;
                changed = 1;
            } else if (temp[i] < temp[i - 1] && temp[i] < temp[i + 1]) {
                result[i] = temp[i] + 1;
                changed = 1;
            }
        }

        free(temp);
    } while (changed);

    return result;
}