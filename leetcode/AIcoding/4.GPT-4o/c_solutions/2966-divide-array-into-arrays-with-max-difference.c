int canArrange(int* arr, int arrSize, int k) {
    int* count = (int*)calloc(k, sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        int mod = ((arr[i] % k) + k) % k;
        count[mod]++;
    }
    if (count[0] % 2 != 0) {
        free(count);
        return 0;
    }
    for (int i = 1; i <= k / 2; i++) {
        if (count[i] != count[k - i]) {
            free(count);
            return 0;
        }
    }
    free(count);
    return 1;
}