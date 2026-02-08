int dfs(int node, int parent, int* hasApple, int* graph, int* graphSize, int* maxPoints) {
    int totalPoints = 0;
    for (int i = 0; i < graphSize[node]; i++) {
        int child = graph[node * 100 + i];
        if (child != parent) {
            totalPoints += dfs(child, node, hasApple, graph, graphSize, maxPoints);
        }
    }
    if (hasApple[node] || totalPoints > 0) {
        totalPoints += 1;
    }
    return totalPoints;
}

int maxPoints(int n, int** edges, int edgesSize, int* hasApple, int hasAppleSize) {
    int* graph = (int*)malloc(n * 100 * sizeof(int));
    int* graphSize = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u * 100 + graphSize[u]++] = v;
        graph[v * 100 + graphSize[v]++] = u;
    }

    int result = dfs(0, -1, hasApple, graph, graphSize, NULL);

    free(graph);
    free(graphSize);

    return result;
}