int* permutationQuery(int* queries, int queriesSize, int m, int* returnSize) {
    int* ans = (int*)malloc(queriesSize * sizeof(int));
    int* perm = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        perm[i] = i + 1;
    }

    for (int i = 0; i < queriesSize; i++) {
        int k = queries[i];
        ans[i] = perm[k - 1];
        for (int j = k - 1; j > 0; j--) {
            perm[j] = perm[j - 1];
        }
        perm[0] = ans[i];
    }

    free(perm);
    *returnSize = queriesSize;
    return ans;
}