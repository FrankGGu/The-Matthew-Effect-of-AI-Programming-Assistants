typedef struct {
    int node;
    int moves;
} State;

int cmp(const void* a, const void* b) {
    return ((State*)b)->moves - ((State*)a)->moves;
}

int reachableNodes(int** edges, int edgesSize, int* edgesColSize, int maxMoves, int n) {
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph[i][j] = -1;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int cnt = edges[i][2];
        graph[u][v] = cnt;
        graph[v][u] = cnt;
    }

    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[0] = 0;

    State* heap = (State*)malloc(n * sizeof(State));
    int heapSize = 0;

    heap[heapSize].node = 0;
    heap[heapSize].moves = 0;
    heapSize++;

    while (heapSize > 0) {
        qsort(heap, heapSize, sizeof(State), cmp);
        State current = heap[heapSize - 1];
        heapSize--;

        int u = current.node;
        int moves = current.moves;

        if (moves != dist[u]) continue;

        for (int v = 0; v < n; v++) {
            if (graph[u][v] == -1) continue;

            int new_moves = moves + graph[u][v] + 1;
            if (new_moves < dist[v]) {
                dist[v] = new_moves;
                heap[heapSize].node = v;
                heap[heapSize].moves = new_moves;
                heapSize++;
            }
        }
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        if (dist[i] <= maxMoves) {
            result++;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int cnt = edges[i][2];

        int a = (dist[u] <= maxMoves) ? (maxMoves - dist[u]) : 0;
        int b = (dist[v] <= maxMoves) ? (maxMoves - dist[v]) : 0;

        result += (a + b < cnt) ? (a + b) : cnt;
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(dist);
    free(heap);

    return result;
}