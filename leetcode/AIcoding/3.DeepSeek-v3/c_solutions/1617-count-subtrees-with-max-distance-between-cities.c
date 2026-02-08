int* countSubgraphsForEachDiameter(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int** dist = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = (i == j) ? 0 : n;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] - 1;
        int v = edges[i][1] - 1;
        dist[u][v] = 1;
        dist[v][u] = 1;
    }

    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (dist[i][j] > dist[i][k] + dist[k][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }

    int* res = (int*)calloc(n - 1, sizeof(int));
    *returnSize = n - 1;

    for (int mask = 1; mask < (1 << n); mask++) {
        int edgeCount = 0;
        int nodeCount = 0;
        int maxDist = 0;

        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                nodeCount++;
                for (int j = i + 1; j < n; j++) {
                    if (mask & (1 << j)) {
                        if (dist[i][j] == 1) {
                            edgeCount++;
                        }
                        if (dist[i][j] > maxDist) {
                            maxDist = dist[i][j];
                        }
                    }
                }
            }
        }

        if (nodeCount >= 2 && edgeCount == nodeCount - 1 && maxDist > 0) {
            res[maxDist - 1]++;
        }
    }

    for (int i = 0; i < n; i++) {
        free(dist[i]);
    }
    free(dist);

    return res;
}