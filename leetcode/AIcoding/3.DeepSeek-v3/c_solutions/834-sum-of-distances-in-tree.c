int* sumOfDistancesInTree(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    *returnSize = n;
    int* res = calloc(n, sizeof(int));
    int* count = calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) count[i] = 1;

    // Build adjacency list
    int** graph = malloc(n * sizeof(int*));
    int* graphSize = calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        graph[i] = malloc(n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        graph[u][graphSize[u]++] = v;
        graph[v][graphSize[v]++] = u;
    }

    // First DFS to calculate count and res[0]
    void dfs1(int node, int parent) {
        for (int i = 0; i < graphSize[node]; i++) {
            int child = graph[node][i];
            if (child == parent) continue;
            dfs1(child, node);
            count[node] += count[child];
            res[node] += res[child] + count[child];
        }
    }

    // Second DFS to calculate all other res values
    void dfs2(int node, int parent) {
        for (int i = 0; i < graphSize[node]; i++) {
            int child = graph[node][i];
            if (child == parent) continue;
            res[child] = res[node] - count[child] + (n - count[child]);
            dfs2(child, node);
        }
    }

    dfs1(0, -1);
    dfs2(0, -1);

    // Free memory
    for (int i = 0; i < n; i++) free(graph[i]);
    free(graph);
    free(graphSize);
    free(count);

    return res;
}