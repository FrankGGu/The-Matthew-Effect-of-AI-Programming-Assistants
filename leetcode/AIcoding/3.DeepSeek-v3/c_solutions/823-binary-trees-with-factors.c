int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int numFactoredBinaryTrees(int* arr, int arrSize) {
    const int MOD = 1000000007;
    qsort(arr, arrSize, sizeof(int), cmp);

    long long *dp = (long long*)malloc(arrSize * sizeof(long long));
    for (int i = 0; i < arrSize; i++) {
        dp[i] = 1;
    }

    for (int i = 0; i < arrSize; i++) {
        int left = 0, right = i - 1;
        while (left <= right) {
            long long product = (long long)arr[left] * arr[right];
            if (product == arr[i]) {
                long long ways = (dp[left] * dp[right]) % MOD;
                if (left != right) {
                    ways = (ways * 2) % MOD;
                }
                dp[i] = (dp[i] + ways) % MOD;
                left++;
                right--;
            } else if (product < arr[i]) {
                left++;
            } else {
                right--;
            }
        }
    }

    long long result = 0;
    for (int i = 0; i < arrSize; i++) {
        result = (result + dp[i]) % MOD;
    }

    free(dp);
    return result;
}