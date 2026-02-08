/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* transformArray(int* arr, int arrSize, int* returnSize) {
    *returnSize = arrSize;
    if (arrSize <= 2) {
        int* result = malloc(arrSize * sizeof(int));
        for (int i = 0; i < arrSize; i++) {
            result[i] = arr[i];
        }
        return result;
    }

    int* result = malloc(arrSize * sizeof(int));
    int changed = 1;

    while (changed) {
        changed = 0;
        for (int i = 1; i < arrSize - 1; i++) {
            if (arr[i] < arr[i-1] && arr[i] < arr[i+1]) {
                result[i] = arr[i] + 1;
                changed = 1;
            } else if (arr[i] > arr[i-1] && arr[i] > arr[i+1]) {
                result[i] = arr[i] - 1;
                changed = 1;
            } else {
                result[i] = arr[i];
            }
        }
        result[0] = arr[0];
        result[arrSize-1] = arr[arrSize-1];

        for (int i = 0; i < arrSize; i++) {
            arr[i] = result[i];
        }
    }

    return result;
}