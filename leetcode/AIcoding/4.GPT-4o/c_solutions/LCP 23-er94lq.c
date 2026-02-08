int* getLeastNumbers(int* arr, int arrSize, int k, int* returnSize) {
    int* result = (int*)malloc(k * sizeof(int));
    if (k == 0) {
        *returnSize = 0;
        return result;
    }

    qsort(arr, arrSize, sizeof(int), cmp);

    for (int i = 0; i < k; i++) {
        result[i] = arr[i];
    }

    *returnSize = k;
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}