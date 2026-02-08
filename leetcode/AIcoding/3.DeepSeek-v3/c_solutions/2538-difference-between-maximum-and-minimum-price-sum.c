typedef struct {
    int node;
    long long price;
    long long max_sum;
} State;

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long* dfs(int node, int parent, int n, long long* price, int** graph, int* graphColSize, long long* result) {
    long long* res = malloc(2 * sizeof(long long));
    res[0] = price[node];
    res[1] = price[node];

    for (int i = 0; i < graphColSize[node]; i++) {
        int neighbor = graph[node][i];
        if (neighbor == parent) continue;

        long long* child_res = dfs(neighbor, node, n, price, graph, graphColSize, result);
        *result = max(*result, res[0] + child_res[1]);
        *result = max(*result, res[1] + child_res[0]);

        res[0] = max(res[0], price[node] + child_res[1]);
        res[1] = max(res[1], price[node] + child_res[0]);
    }

    return res;
}

long long maxOutput(int n, int** edges, int edgesSize, int* edgesColSize, int* price, int priceSize) {
    int** graph = malloc(n * sizeof(int*));
    int* graphColSize = calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graphColSize[u]++;
        graphColSize[v]++;
    }

    for (int i = 0; i < n; i++) {
        graph[i] = malloc(graphColSize[i] * sizeof(int));
        graphColSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][graphColSize[u]++] = v;
        graph[v][graphColSize[v]++] = u;
    }

    long long result = 0;
    long long* res = dfs(0, -1, n, (long long*)price, graph, graphColSize, &result);
    result = max(result, res[0] - price[0]);
    result = max(result, res[1] - price[0]);

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphColSize);
    free(res);

    return result;
}