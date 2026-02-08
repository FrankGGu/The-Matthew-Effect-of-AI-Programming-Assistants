int* minEdgeReversals(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int** graph = (int**)malloc(n * sizeof(int*));
    int** reverse = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        reverse[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph[i][j] = 0;
            reverse[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][v] = 1;
        reverse[v][u] = 1;
    }

    int* res = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int* dp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) dp[i] = -1;

    int dfs(int node, int parent) {
        if (dp[node] != -1) return dp[node];
        int cnt = 0;
        for (int i = 0; i < n; i++) {
            if (i == parent) continue;
            if (graph[node][i]) {
                cnt += dfs(i, node);
            }
            if (reverse[node][i]) {
                cnt += dfs(i, node) + 1;
            }
        }
        return dp[node] = cnt;
    }

    void dfs2(int node, int parent, int cost) {
        res[node] = cost;
        for (int i = 0; i < n; i++) {
            if (i == parent) continue;
            if (graph[node][i]) {
                dfs2(i, node, cost + 1);
            }
            if (reverse[node][i]) {
                dfs2(i, node, cost - 1);
            }
        }
    }

    int root_cost = dfs(0, -1);
    dfs2(0, -1, root_cost);

    for (int i = 0; i < n; i++) {
        free(graph[i]);
        free(reverse[i]);
    }
    free(graph);
    free(reverse);
    free(dp);

    return res;
}