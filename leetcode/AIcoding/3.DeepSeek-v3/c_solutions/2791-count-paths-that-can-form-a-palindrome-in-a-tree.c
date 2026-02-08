/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* countPairs(int n, int** edges, int edgesSize, int* edgesColSize, int* queries, int queriesSize, int* returnSize) {
    int *degree = (int*)calloc(n + 1, sizeof(int));
    int *sortedDegree = (int*)malloc((n + 1) * sizeof(int));
    int **adj = (int**)malloc((n + 1) * sizeof(int*));
    int *cnt = (int*)calloc(n + 1, sizeof(int));

    for (int i = 1; i <= n; i++) {
        adj[i] = (int*)malloc((n + 1) * sizeof(int));
        memset(adj[i], 0, (n + 1) * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        degree[u]++;
        degree[v]++;
        adj[u][v]++;
        adj[v][u]++;
    }

    for (int i = 1; i <= n; i++) {
        sortedDegree[i] = degree[i];
    }

    for (int i = 1; i <= n; i++) {
        for (int j = i + 1; j <= n; j++) {
            cnt[degree[i] + degree[j] - adj[i][j]]++;
        }
    }

    int *res = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int q = queries[i];
        int total = 0;
        for (int j = q + 1; j <= 2 * n; j++) {
            total += cnt[j];
        }
        res[i] = total;
    }

    free(degree);
    free(sortedDegree);
    for (int i = 1; i <= n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(cnt);

    return res;
}