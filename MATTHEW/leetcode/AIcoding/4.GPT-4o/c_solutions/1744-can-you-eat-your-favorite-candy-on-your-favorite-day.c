bool[] canEat(int[] candiesCount, int[][] queries) {
    int n = sizeof(candiesCount) / sizeof(candiesCount[0]);
    long long prefix[n + 1];
    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + candiesCount[i];
    }
    bool *result = malloc(sizeof(bool) * sizeof(queries) / sizeof(queries[0]));
    for (int i = 0; i < sizeof(queries) / sizeof(queries[0]); i++) {
        int favoriteType = queries[i][0], favoriteDay = queries[i][1], dailyCap = queries[i][2];
        long long minCandies = (long long)favoriteDay + 1;
        long long maxCandies = (long long)(favoriteDay + 1) * dailyCap;
        long long totalCandies = prefix[favoriteType];
        long long nextTypeCandies = prefix[favoriteType + 1];
        result[i] = (totalCandies < maxCandies && minCandies <= nextTypeCandies);
    }
    return result;
}