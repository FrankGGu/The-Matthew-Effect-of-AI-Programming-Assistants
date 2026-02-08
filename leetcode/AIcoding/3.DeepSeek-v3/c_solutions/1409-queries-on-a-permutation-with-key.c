/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* processQueries(int* queries, int queriesSize, int m, int* returnSize) {
    int *P = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        P[i] = i + 1;
    }

    int *result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int query = queries[i];
        int pos = 0;
        while (P[pos] != query) {
            pos++;
        }
        result[i] = pos;

        for (int j = pos; j > 0; j--) {
            P[j] = P[j-1];
        }
        P[0] = query;
    }

    free(P);
    return result;
}