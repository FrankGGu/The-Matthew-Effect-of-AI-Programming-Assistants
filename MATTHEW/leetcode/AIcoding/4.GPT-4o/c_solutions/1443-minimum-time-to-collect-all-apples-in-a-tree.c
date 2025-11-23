int minTime(int n, int** edges, int edgesSize, int* edgesColSize, int* hasApple, int hasAppleSize) {
    int* graph = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]] |= (1 << edges[i][1]);
        graph[edges[i][1]] |= (1 << edges[i][0]);
    }

    int dfs(int node, int parent) {
        int time = 0;
        for (int i = 0; i < n; i++) {
            if (graph[node] & (1 << i) && i != parent) {
                time += dfs(i, node);
            }
        }
        if (time > 0 || hasApple[node]) {
            return time + 2;
        }
        return 0;
    }

    int result = dfs(0, -1);
    free(graph);
    return result > 0 ? result - 2 : 0;
}