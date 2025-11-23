/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* countPairs(int n, int** edges, int edgesSize, int* edgesColSize, int* queries, int queriesSize, int* returnSize) {
    int *deg = (int*)calloc(n + 1, sizeof(int));
    int *sortedDeg = (int*)malloc((n + 1) * sizeof(int));
    int *res = (int*)calloc(queriesSize, sizeof(int));

    int maxEdge = 0;
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        deg[u]++;
        deg[v]++;
        if (u > maxEdge) maxEdge = u;
        if (v > maxEdge) maxEdge = v;
    }

    for (int i = 1; i <= n; i++) {
        sortedDeg[i] = deg[i];
    }

    int *cnt = (int*)calloc(2 * maxEdge + 5, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        if (u > v) {
            int temp = u;
            u = v;
            v = temp;
        }
        cnt[u * (n + 1) + v]++;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = i + 1; j <= n; j++) {
            int shared = cnt[i * (n + 1) + j];
            int total = deg[i] + deg[j] - shared;
            for (int k = 0; k < queriesSize; k++) {
                if (total > queries[k]) {
                    res[k]++;
                }
            }
        }
    }

    *returnSize = queriesSize;
    free(deg);
    free(sortedDeg);
    free(cnt);
    return res;
}