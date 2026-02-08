int minimumAbsDifference(int* arr, int arrSize, int** returnColumnSizes) {
    qsort(arr, arrSize, sizeof(int), cmp);
    int minDiff = INT_MAX, count = 0;
    int** result = (int**)malloc(sizeof(int*) * (arrSize - 1));

    for (int i = 1; i < arrSize; i++) {
        int diff = arr[i] - arr[i - 1];
        if (diff < minDiff) {
            minDiff = diff;
            count = 0;
        }
        if (diff == minDiff) {
            result[count] = (int*)malloc(sizeof(int) * 2);
            result[count][0] = arr[i - 1];
            result[count][1] = arr[i];
            count++;
        }
    }

    *returnColumnSizes = (int*)malloc(sizeof(int) * count);
    for (int i = 0; i < count; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}