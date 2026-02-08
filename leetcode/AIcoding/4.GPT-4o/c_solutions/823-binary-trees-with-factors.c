int numFactoredBinaryTrees(int* arr, int arrSize) {
    long long mod = 1000000007;
    long long* dp = (long long*)calloc(arrSize, sizeof(long long));
    int* sortedArr = (int*)malloc(arrSize * sizeof(int));
    memcpy(sortedArr, arr, arrSize * sizeof(int));
    qsort(sortedArr, arrSize, sizeof(int), cmp);

    for (int i = 0; i < arrSize; i++) {
        dp[i] = 1; 
        for (int j = 0; j < i; j++) {
            if (sortedArr[i] % sortedArr[j] == 0) {
                int right = sortedArr[i] / sortedArr[j];
                for (int k = 0; k < arrSize; k++) {
                    if (sortedArr[k] == right) {
                        dp[i] = (dp[i] + dp[j] * dp[k]) % mod;
                        break;
                    }
                }
            }
        }
    }

    long long result = 0;
    for (int i = 0; i < arrSize; i++) {
        result = (result + dp[i]) % mod;
    }

    free(dp);
    free(sortedArr);
    return (int)result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}