int* platesBetweenCandles(char *s, int* queries, int queriesSize, int* returnSize) {
    int n = strlen(s);
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* prefixSum = (int*)malloc((n + 1) * sizeof(int));
    int* leftCandle = (int*)malloc(n * sizeof(int));
    int* rightCandle = (int*)malloc(n * sizeof(int));

    prefixSum[0] = 0;
    for (int i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + (s[i] == '|');
    }

    int lastCandle = -1;
    for (int i = 0; i < n; i++) {
        if (s[i] == '|') lastCandle = i;
        leftCandle[i] = lastCandle;
    }

    lastCandle = -1;
    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == '|') lastCandle = i;
        rightCandle[i] = lastCandle;
    }

    for (int i = 0; i < queriesSize; i++) {
        int left = queries[2 * i];
        int right = queries[2 * i + 1];
        int leftIndex = rightCandle[left];
        int rightIndex = leftCandle[right];
        if (leftIndex == -1 || rightIndex == -1 || leftIndex >= rightIndex) {
            result[i] = 0;
        } else {
            result[i] = prefixSum[rightIndex + 1] - prefixSum[leftIndex];
        }
    }

    free(prefixSum);
    free(leftCandle);
    free(rightCandle);

    *returnSize = queriesSize;
    return result;
}