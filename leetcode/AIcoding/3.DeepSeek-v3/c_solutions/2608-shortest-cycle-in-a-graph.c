int findShortestCycle(int n, int** edges, int edgesSize, int* edgesColSize) {
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][v] = 1;
        graph[v][u] = 1;
    }

    int min_cycle = INT_MAX;

    for (int i = 0; i < n; i++) {
        int* dist = (int*)malloc(n * sizeof(int));
        int* parent = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[j] = -1;
            parent[j] = -1;
        }

        dist[i] = 0;
        int* queue = (int*)malloc(n * sizeof(int));
        int front = 0, rear = 0;
        queue[rear++] = i;

        while (front < rear) {
            int u = queue[front++];
            for (int v = 0; v < n; v++) {
                if (graph[u][v]) {
                    if (dist[v] == -1) {
                        dist[v] = dist[u] + 1;
                        parent[v] = u;
                        queue[rear++] = v;
                    } else if (parent[u] != v && parent[v] != u) {
                        int cycle_length = dist[u] + dist[v] + 1;
                        if (cycle_length < min_cycle) {
                            min_cycle = cycle_length;
                        }
                    }
                }
            }
        }

        free(dist);
        free(parent);
        free(queue);
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);

    return min_cycle == INT_MAX ? -1 : min_cycle;
}