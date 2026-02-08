int maximumElementAfterDecreasingAndRearranging(int* arr, int arrSize) {
    if (arrSize == 0) return 0;
    qsort(arr, arrSize, sizeof(int), cmp);
    arr[0] = 1;
    for (int i = 1; i < arrSize; i++) {
        arr[i] = fmax(arr[i], arr[i - 1] + 1);
    }
    return arr[arrSize - 1];
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}