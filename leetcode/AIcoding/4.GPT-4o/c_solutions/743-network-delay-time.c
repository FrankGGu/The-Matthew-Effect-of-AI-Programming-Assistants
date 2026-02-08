#define INF 0x3f3f3f3f

int networkDelayTime(int** times, int timesSize, int* timesColSize, int N, int K) {
    int dist[N + 1];
    for (int i = 1; i <= N; i++) {
        dist[i] = INF;
    }
    dist[K] = 0;

    int graph[N + 1][N + 1];
    for (int i = 1; i <= N; i++) {
        for (int j = 1; j <= N; j++) {
            graph[i][j] = INF;
        }
    }

    for (int i = 0; i < timesSize; i++) {
        int u = times[i][0], v = times[i][1], w = times[i][2];
        graph[u][v] = w;
    }

    for (int count = 1; count < N; count++) {
        for (int u = 1; u <= N; u++) {
            for (int v = 1; v <= N; v++) {
                if (dist[u] != INF && dist[u] + graph[u][v] < dist[v]) {
                    dist[v] = dist[u] + graph[u][v];
                }
            }
        }
    }

    int maxDelay = 0;
    for (int i = 1; i <= N; i++) {
        if (dist[i] == INF) return -1;
        if (dist[i] > maxDelay) maxDelay = dist[i];
    }

    return maxDelay;
}