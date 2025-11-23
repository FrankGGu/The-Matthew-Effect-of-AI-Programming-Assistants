int minReorder(int n, int** connections, int connectionsSize, int* connectionsColSize) {
    int** graph = (int**)malloc(n * sizeof(int*));
    int* graphSize = (int*)calloc(n, sizeof(int));
    int* graphCapacity = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        graphCapacity[i] = 10;
        graph[i] = (int*)malloc(graphCapacity[i] * sizeof(int));
    }

    for (int i = 0; i < connectionsSize; i++) {
        int a = connections[i][0];
        int b = connections[i][1];

        if (graphSize[a] >= graphCapacity[a]) {
            graphCapacity[a] *= 2;
            graph[a] = (int*)realloc(graph[a], graphCapacity[a] * sizeof(int));
        }
        if (graphSize[b] >= graphCapacity[b]) {
            graphCapacity[b] *= 2;
            graph[b] = (int*)realloc(graph[b], graphCapacity[b] * sizeof(int));
        }

        graph[a][graphSize[a]++] = b;
        graph[b][graphSize[b]++] = -a - 1;
    }

    int* visited = (int*)calloc(n, sizeof(int));
    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;
    int count = 0;

    queue[rear++] = 0;
    visited[0] = 1;

    while (front < rear) {
        int node = queue[front++];

        for (int i = 0; i < graphSize[node]; i++) {
            int neighbor = graph[node][i];
            int absNeighbor = neighbor < 0 ? -neighbor - 1 : neighbor;

            if (!visited[absNeighbor]) {
                if (neighbor >= 0) {
                    count++;
                }
                visited[absNeighbor] = 1;
                queue[rear++] = absNeighbor;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphSize);
    free(graphCapacity);
    free(visited);
    free(queue);

    return count;
}