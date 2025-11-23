int cmp(const void* a, const void* b) {
    long long diff = *(long long*)a - *(long long*)b;
    return diff > 0 ? 1 : (diff < 0 ? -1 : 0);
}

long long putMarbles(int* weights, int weightsSize, int k) {
    if (k == 1 || k == weightsSize) {
        return 0;
    }

    int n = weightsSize;
    long long* pairs = malloc((n - 1) * sizeof(long long));

    for (int i = 0; i < n - 1; i++) {
        pairs[i] = (long long)weights[i] + weights[i + 1];
    }

    qsort(pairs, n - 1, sizeof(long long), cmp);

    long long min_sum = 0;
    long long max_sum = 0;

    for (int i = 0; i < k - 1; i++) {
        min_sum += pairs[i];
        max_sum += pairs[n - 2 - i];
    }

    free(pairs);
    return max_sum - min_sum;
}