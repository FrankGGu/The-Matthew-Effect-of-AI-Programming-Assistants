bool canArrange(int* arr, int arrSize, int k) {
    int* freq = (int*)calloc(k, sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        int rem = arr[i] % k;
        if (rem < 0) rem += k;
        freq[rem]++;
    }

    if (freq[0] % 2 != 0) return false;

    for (int i = 1; i <= k / 2; i++) {
        if (freq[i] != freq[k - i]) return false;
    }

    free(freq);
    return true;
}