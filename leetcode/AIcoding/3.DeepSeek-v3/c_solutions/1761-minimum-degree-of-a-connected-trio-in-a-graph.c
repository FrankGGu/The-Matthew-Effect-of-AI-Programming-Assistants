int min(int a, int b) {
    return a < b ? a : b;
}

int minTrioDegree(int n, int** edges, int edgesSize, int* edgesColSize) {
    int adj[n + 1][n + 1];
    int degree[n + 1];

    for (int i = 1; i <= n; i++) {
        degree[i] = 0;
        for (int j = 1; j <= n; j++) {
            adj[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][v] = 1;
        adj[v][u] = 1;
        degree[u]++;
        degree[v]++;
    }

    int ans = INT_MAX;
    for (int i = 1; i <= n; i++) {
        for (int j = i + 1; j <= n; j++) {
            if (adj[i][j]) {
                for (int k = j + 1; k <= n; k++) {
                    if (adj[i][k] && adj[j][k]) {
                        ans = min(ans, degree[i] + degree[j] + degree[k] - 6);
                    }
                }
            }
        }
    }

    return ans == INT_MAX ? -1 : ans;
}