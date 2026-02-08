int min(int a, int b) {
    return a < b ? a : b;
}

int numberOfSets(int n, int maxDistance, int** roads, int roadsSize, int* roadsColSize) {
    int dist[10][10];
    int res = 0;

    for (int mask = 0; mask < (1 << n); mask++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i == j) dist[i][j] = 0;
                else dist[i][j] = 1e9;
            }
        }

        for (int i = 0; i < roadsSize; i++) {
            int u = roads[i][0], v = roads[i][1], w = roads[i][2];
            if ((mask >> u & 1) && (mask >> v & 1)) {
                if (w < dist[u][v]) {
                    dist[u][v] = w;
                    dist[v][u] = w;
                }
            }
        }

        for (int k = 0; k < n; k++) {
            if (!(mask >> k & 1)) continue;
            for (int i = 0; i < n; i++) {
                if (!(mask >> i & 1)) continue;
                for (int j = 0; j < n; j++) {
                    if (!(mask >> j & 1)) continue;
                    if (dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }

        int valid = 1;
        for (int i = 0; i < n && valid; i++) {
            if (!(mask >> i & 1)) continue;
            for (int j = i + 1; j < n && valid; j++) {
                if (!(mask >> j & 1)) continue;
                if (dist[i][j] > maxDistance) {
                    valid = 0;
                }
            }
        }

        if (valid) res++;
    }

    return res;
}