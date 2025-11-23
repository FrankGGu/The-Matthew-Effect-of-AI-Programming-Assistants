int chaseGame(int** edges, int edgesSize, int* edgesColSize, int startA, int startB) {
    int n = edgesSize + 1;
    int graph[n + 1][3];
    int deg[n + 1];
    memset(deg, 0, sizeof(deg));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        graph[u][deg[u]++] = v;
        graph[v][deg[v]++] = u;
    }

    int distA[n + 1], distB[n + 1];
    memset(distA, -1, sizeof(distA));
    memset(distB, -1, sizeof(distB));

    int queue[n];
    int front = 0, rear = 0;

    queue[rear++] = startA;
    distA[startA] = 0;
    while (front < rear) {
        int u = queue[front++];
        for (int i = 0; i < deg[u]; i++) {
            int v = graph[u][i];
            if (distA[v] == -1) {
                distA[v] = distA[u] + 1;
                queue[rear++] = v;
            }
        }
    }

    front = rear = 0;
    queue[rear++] = startB;
    distB[startB] = 0;
    while (front < rear) {
        int u = queue[front++];
        for (int i = 0; i < deg[u]; i++) {
            int v = graph[u][i];
            if (distB[v] == -1) {
                distB[v] = distB[u] + 1;
                queue[rear++] = v;
            }
        }
    }

    if (distA[startB] == 1) return 1;

    int cycle[n + 1];
    memset(cycle, 0, sizeof(cycle));
    int indeg[n + 1];
    memcpy(indeg, deg, sizeof(deg));

    front = rear = 0;
    for (int i = 1; i <= n; i++) {
        if (indeg[i] == 1) {
            queue[rear++] = i;
        }
    }

    while (front < rear) {
        int u = queue[front++];
        cycle[u] = 0;
        for (int i = 0; i < deg[u]; i++) {
            int v = graph[u][i];
            if (--indeg[v] == 1) {
                queue[rear++] = v;
            }
        }
    }

    for (int i = 1; i <= n; i++) {
        if (indeg[i] > 1) {
            cycle[i] = 1;
        }
    }

    int res = 1;
    for (int i = 1; i <= n; i++) {
        if (distA[i] > distB[i] + 1) {
            if (cycle[i]) {
                return -1;
            }
            res = fmax(res, distA[i]);
        }
    }

    return res;
}