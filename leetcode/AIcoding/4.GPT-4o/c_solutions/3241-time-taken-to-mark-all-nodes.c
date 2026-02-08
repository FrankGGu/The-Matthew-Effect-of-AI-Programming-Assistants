int timeTaken(int n, int edges[][2], int edgesSize) {
    int graph[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        graph[u][v] = 1;
        graph[v][u] = 1;
    }

    int visited[n];
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    int maxTime = 0;

    void dfs(int node, int time) {
        visited[node] = 1;
        for (int i = 0; i < n; i++) {
            if (graph[node][i] && !visited[i]) {
                dfs(i, time + 1);
                if (time + 1 > maxTime) {
                    maxTime = time + 1;
                }
            }
        }
    }

    dfs(0, 0);
    return maxTime;
}