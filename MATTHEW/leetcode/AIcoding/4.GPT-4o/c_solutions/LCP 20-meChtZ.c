int minBusStops(int** routes, int routesSize, int* routesColSize, int S, int T) {
    if (S == T) return 0;

    int n = routesSize;
    int graph[500][500] = {0};
    int visited[500] = {0};
    int queue[500] = {0};
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < routesColSize[i]; j++) {
            for (int k = j + 1; k < routesColSize[i]; k++) {
                graph[routes[i][j]][routes[i][k]] = 1;
                graph[routes[i][k]][routes[i][j]] = 1;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (routes[i][0] == S) {
            visited[i] = 1;
            queue[rear++] = i;
        }
    }

    int stops = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int curr = queue[front++];
            for (int j = 0; j < routesColSize[curr]; j++) {
                if (routes[curr][j] == T) return stops + 1;
                for (int k = 0; k < n; k++) {
                    if (!visited[k] && graph[routes[curr][j]][routes[k][0]]) {
                        visited[k] = 1;
                        queue[rear++] = k;
                    }
                }
            }
        }
        stops++;
    }

    return -1;
}