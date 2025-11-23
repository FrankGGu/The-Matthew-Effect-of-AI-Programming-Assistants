int* arrayRankTransform(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    int* sorted = (int*)malloc(arrSize * sizeof(int));
    memcpy(sorted, arr, arrSize * sizeof(int));
    qsort(sorted, arrSize, sizeof(int), compare);

    int rank = 1;
    for (int i = 0; i < arrSize; i++) {
        if (i == 0 || sorted[i] != sorted[i - 1]) {
            rank++;
        }
        result[i] = rank - 1;
    }

    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < arrSize; j++) {
            if (arr[i] == sorted[j]) {
                result[i] = result[j];
                break;
            }
        }
    }

    free(sorted);
    *returnSize = arrSize;
    return result;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}