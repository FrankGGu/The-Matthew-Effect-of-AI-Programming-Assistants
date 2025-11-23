double trimMean(int* arr, int arrSize) {
    int n = arrSize / 20;
    qsort(arr, arrSize, sizeof(int), cmp);
    double sum = 0;
    for (int i = n; i < arrSize - n; i++) {
        sum += arr[i];
    }
    return sum / (arrSize - 2 * n);
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}