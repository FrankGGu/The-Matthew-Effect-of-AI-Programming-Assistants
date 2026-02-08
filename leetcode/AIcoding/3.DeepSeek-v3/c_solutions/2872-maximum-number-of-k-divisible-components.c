int dfs(int node, int parent, int* values, int** graph, int* graphColSize, int k, int* count) {
    long long sum = values[node];
    for (int i = 0; i < graphColSize[node]; i++) {
        int neighbor = graph[node][i];
        if (neighbor == parent) continue;
        sum += dfs(neighbor, node, values, graph, graphColSize, k, count);
    }
    if (sum % k == 0) {
        (*count)++;
        return 0;
    }
    return sum;
}

int maxKDivisibleComponents(int n, int** edges, int edgesSize, int* edgesColSize, int* values, int valuesSize, int k) {
    int** graph = (int**)malloc(n * sizeof(int*));
    int* graphColSize = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc((n - 1) * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][graphColSize[u]++] = v;
        graph[v][graphColSize[v]++] = u;
    }

    int count = 0;
    dfs(0, -1, values, graph, graphColSize, k, &count);

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphColSize);

    return count;
}