int collectTheCoins(int* coins, int coinsSize, int** edges, int edgesSize, int* edgesColSize) {
    int n = coinsSize;
    int deg[n];
    for (int i = 0; i < n; i++) deg[i] = 0;

    int* adj[n];
    int adjSize[n];
    for (int i = 0; i < n; i++) {
        adj[i] = malloc(n * sizeof(int));
        adjSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        adj[u][adjSize[u]++] = v;
        adj[v][adjSize[v]++] = u;
        deg[u]++;
        deg[v]++;
    }

    int q[n], front = 0, rear = 0;
    for (int i = 0; i < n; i++) {
        if (deg[i] == 1 && coins[i] == 0) {
            q[rear++] = i;
        }
    }

    int remain = n;
    while (front < rear) {
        int u = q[front++];
        remain--;
        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i];
            if (--deg[v] == 1 && coins[v] == 0) {
                q[rear++] = v;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (deg[i] == 1 && coins[i] == 1) {
            q[rear++] = i;
        }
    }

    int dist[n];
    for (int i = 0; i < n; i++) dist[i] = 0;

    while (front < rear) {
        int u = q[front++];
        remain--;
        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i];
            if (--deg[v] == 1) {
                dist[v] = dist[u] + 1;
                q[rear++] = v;
            }
        }
    }

    int cnt = 0;
    for (int i = 0; i < n; i++) {
        if (dist[i] >= 2) cnt++;
    }

    for (int i = 0; i < n; i++) free(adj[i]);

    return cnt == 0 ? 0 : (cnt - 1) * 2;
}