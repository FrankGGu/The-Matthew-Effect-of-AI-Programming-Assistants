int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int calculateSum(int* arr, int arrSize, int value) {
    int sum = 0;
    for (int i = 0; i < arrSize; i++) {
        sum += (arr[i] > value) ? value : arr[i];
    }
    return sum;
}

int findBestValue(int* arr, int arrSize, int target) {
    qsort(arr, arrSize, sizeof(int), cmp);

    int prefix = 0;
    for (int i = 0; i < arrSize; i++) {
        int x = (target - prefix) / (arrSize - i);
        if (x < arr[i]) {
            double t = (double)(target - prefix) / (arrSize - i);
            if (t - x > 0.5) {
                return x + 1;
            } else {
                return x;
            }
        }
        prefix += arr[i];
    }

    return arr[arrSize - 1];
}