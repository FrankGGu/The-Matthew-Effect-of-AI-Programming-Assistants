/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* minEdgeReversals(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int** graph = (int**)malloc(n * sizeof(int*));
    int* graphSize = (int*)calloc(n, sizeof(int));
    int** graphDir = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(2 * n * sizeof(int));
        graphDir[i] = (int*)malloc(2 * n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][graphSize[u]] = v;
        graphDir[u][graphSize[u]] = 1;
        graphSize[u]++;
        graph[v][graphSize[v]] = u;
        graphDir[v][graphSize[v]] = -1;
        graphSize[v]++;
    }

    int* res = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int* dp = (int*)calloc(n, sizeof(int));

    void dfs1(int u, int parent) {
        for (int i = 0; i < graphSize[u]; i++) {
            int v = graph[u][i];
            if (v == parent) continue;
            dfs1(v, u);
            dp[u] += dp[v] + (graphDir[u][i] == -1 ? 1 : 0);
        }
    }

    void dfs2(int u, int parent) {
        res[u] = dp[u];
        for (int i = 0; i < graphSize[u]; i++) {
            int v = graph[u][i];
            if (v == parent) continue;
            int old_dp_u = dp[u];
            int old_dp_v = dp[v];

            if (graphDir[u][i] == 1) {
                dp[u] -= (dp[v] + 1);
                dp[v] += (dp[u] + 1);
            } else {
                dp[u] -= dp[v];
                dp[v] += dp[u];
            }

            dfs2(v, u);

            dp[u] = old_dp_u;
            dp[v] = old_dp_v;
        }
    }

    dfs1(0, -1);
    dfs2(0, -1);

    for (int i = 0; i < n; i++) {
        free(graph[i]);
        free(graphDir[i]);
    }
    free(graph);
    free(graphDir);
    free(graphSize);
    free(dp);

    return res;
}