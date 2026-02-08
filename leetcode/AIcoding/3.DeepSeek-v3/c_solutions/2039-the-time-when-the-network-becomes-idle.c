int networkBecomesIdle(int** edges, int edgesSize, int* edgesColSize, int* patience, int patienceSize) {
    int n = patienceSize;
    int* graph[n];
    int graphSize[n];
    for (int i = 0; i < n; i++) {
        graphSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graphSize[u]++;
        graphSize[v]++;
    }

    for (int i = 0; i < n; i++) {
        graph[i] = malloc(graphSize[i] * sizeof(int));
        graphSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][graphSize[u]++] = v;
        graph[v][graphSize[v]++] = u;
    }

    int dist[n];
    for (int i = 0; i < n; i++) dist[i] = -1;
    dist[0] = 0;

    int queue[n];
    int front = 0, rear = 0;
    queue[rear++] = 0;

    while (front < rear) {
        int u = queue[front++];
        for (int i = 0; i < graphSize[u]; i++) {
            int v = graph[u][i];
            if (dist[v] == -1) {
                dist[v] = dist[u] + 1;
                queue[rear++] = v;
            }
        }
    }

    int maxTime = 0;
    for (int i = 1; i < n; i++) {
        int roundTrip = 2 * dist[i];
        int lastSend = (roundTrip - 1) / patience[i] * patience[i];
        int totalTime = lastSend + roundTrip;
        if (totalTime > maxTime) {
            maxTime = totalTime;
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }

    return maxTime + 1;
}