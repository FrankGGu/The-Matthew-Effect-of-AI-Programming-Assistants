/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* pancakeSort(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(2 * arrSize * sizeof(int));
    *returnSize = 0;

    for (int i = arrSize; i > 0; i--) {
        int pos = 0;
        while (arr[pos] != i) {
            pos++;
        }

        if (pos == i - 1) {
            continue;
        }

        if (pos != 0) {
            for (int j = 0; j <= pos / 2; j++) {
                int temp = arr[j];
                arr[j] = arr[pos - j];
                arr[pos - j] = temp;
            }
            result[(*returnSize)++] = pos + 1;
        }

        for (int j = 0; j <= (i - 1) / 2; j++) {
            int temp = arr[j];
            arr[j] = arr[i - 1 - j];
            arr[i - 1 - j] = temp;
        }
        result[(*returnSize)++] = i;
    }

    return result;
}