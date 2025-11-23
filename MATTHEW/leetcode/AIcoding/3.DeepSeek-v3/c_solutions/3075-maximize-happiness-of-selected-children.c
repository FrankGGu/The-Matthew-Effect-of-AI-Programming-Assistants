int cmp(const void* a, const void* b) {
    long long diff = *(long long*)b - *(long long*)a;
    return diff > 0 ? 1 : (diff < 0 ? -1 : 0);
}

long long maximumHappinessSum(int* happiness, int happinessSize, int k) {
    long long* arr = (long long*)malloc(happinessSize * sizeof(long long));
    for (int i = 0; i < happinessSize; i++) {
        arr[i] = happiness[i];
    }

    qsort(arr, happinessSize, sizeof(long long), cmp);

    long long sum = 0;
    for (int i = 0; i < k; i++) {
        long long val = arr[i] - i;
        if (val > 0) {
            sum += val;
        } else {
            break;
        }
    }

    free(arr);
    return sum;
}