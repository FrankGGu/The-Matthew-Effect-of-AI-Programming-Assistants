int minimumTime(int** edges, int edgesSize, int* edgesColSize, int* patience, int patienceSize) {
    int n = edgesSize + 1;
    int graph[n][n];
    int dist[n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            graph[i][j] = (i == j) ? 0 : 1e9;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]][edges[i][1]] = 1;
        graph[edges[i][1]][edges[i][0]] = 1;
    }

    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (graph[i][j] > graph[i][k] + graph[k][j]) {
                    graph[i][j] = graph[i][k] + graph[k][j];
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        dist[i] = graph[0][i];
    }

    int maxTime = 0;
    for (int i = 1; i < n; i++) {
        int roundTripTime = dist[i] * 2;
        int waitTime = (roundTripTime + patience[i - 1] - 1) / patience[i - 1] * patience[i - 1];
        maxTime = max(maxTime, waitTime + dist[i]);
    }

    return maxTime;
}