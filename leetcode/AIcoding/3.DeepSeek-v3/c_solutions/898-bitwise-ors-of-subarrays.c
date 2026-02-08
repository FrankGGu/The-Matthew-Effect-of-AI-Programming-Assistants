int subarrayBitwiseORs(int* arr, int arrSize) {
    if (arrSize == 0) return 0;

    int max_val = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] > max_val) max_val = arr[i];
    }

    int mask = 1;
    while (mask <= max_val) mask <<= 1;
    mask -= 1;

    int* dp = (int*)malloc(arrSize * sizeof(int));
    int* seen = (int*)calloc(mask + 1, sizeof(int));
    int result = 0;

    for (int j = 0; j < arrSize; j++) {
        dp[j] = arr[j];
        if (!seen[arr[j]]) {
            seen[arr[j]] = 1;
            result++;
        }
        for (int i = j - 1; i >= 0; i--) {
            if ((arr[i] | dp[i]) == dp[i]) break;
            dp[i] |= arr[j];
            if (!seen[dp[i]]) {
                seen[dp[i]] = 1;
                result++;
            }
        }
    }

    free(dp);
    free(seen);
    return result;
}