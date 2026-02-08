/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* arrayRankTransform(int* arr, int arrSize, int* returnSize) {
    if (arrSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int* sorted = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        sorted[i] = arr[i];
    }

    for (int i = 0; i < arrSize - 1; i++) {
        for (int j = 0; j < arrSize - i - 1; j++) {
            if (sorted[j] > sorted[j + 1]) {
                int temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }

    int* rankMap = (int*)malloc(2000000001 * sizeof(int));
    int rank = 1;
    for (int i = 0; i < arrSize; i++) {
        if (i == 0 || sorted[i] != sorted[i - 1]) {
            rankMap[sorted[i] + 1000000000] = rank++;
        }
    }

    int* result = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        result[i] = rankMap[arr[i] + 1000000000];
    }

    free(sorted);
    free(rankMap);
    *returnSize = arrSize;
    return result;
}