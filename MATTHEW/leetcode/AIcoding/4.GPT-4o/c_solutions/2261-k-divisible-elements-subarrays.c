int countKDivisibleSubarrays(int* arr, int arrSize, int k) {
    int count = 0;
    int* prefix = (int*)malloc((arrSize + 1) * sizeof(int));
    prefix[0] = 0;

    for (int i = 0; i < arrSize; i++) {
        prefix[i + 1] = prefix[i] + (arr[i] % k == 0);
    }

    for (int i = 0; i <= arrSize; i++) {
        for (int j = i + 1; j <= arrSize; j++) {
            if (prefix[j] - prefix[i] > 0) {
                count++;
            }
        }
    }

    free(prefix);
    return count;
}