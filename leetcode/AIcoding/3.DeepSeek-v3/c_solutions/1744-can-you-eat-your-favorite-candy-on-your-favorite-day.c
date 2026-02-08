bool* canEat(int* candiesCount, int candiesCountSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    long long* prefixSum = (long long*)malloc((candiesCountSize + 1) * sizeof(long long));
    prefixSum[0] = 0;
    for (int i = 0; i < candiesCountSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + candiesCount[i];
    }

    for (int i = 0; i < queriesSize; i++) {
        int type = queries[i][0];
        int day = queries[i][1];
        int cap = queries[i][2];

        long long minCandies = day;
        long long maxCandies = (long long)cap * (day + 1);

        long long typeStart = prefixSum[type] + 1;
        long long typeEnd = prefixSum[type + 1];

        result[i] = (maxCandies > typeStart && minCandies < typeEnd);
    }

    free(prefixSum);
    return result;
}