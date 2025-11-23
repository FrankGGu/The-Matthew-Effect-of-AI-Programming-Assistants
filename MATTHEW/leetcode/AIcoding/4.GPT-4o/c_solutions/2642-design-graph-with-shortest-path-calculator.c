typedef struct {
    int** graph;
    int size;
} Graph;

Graph* graphCreate(int n) {
    Graph* g = (Graph*)malloc(sizeof(Graph));
    g->graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        g->graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            g->graph[i][j] = (i == j) ? 0 : INT_MAX;
        }
    }
    g->size = n;
    return g;
}

void graphAddEdge(Graph* obj, int u, int v, int weight) {
    obj->graph[u][v] = weight;
}

int graphShortestPath(Graph* obj, int start, int end) {
    int n = obj->size;
    int* dist = (int*)malloc(n * sizeof(int));
    bool* visited = (bool*)malloc(n * sizeof(bool));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
        visited[i] = false;
    }
    dist[start] = 0;

    for (int count = 0; count < n - 1; count++) {
        int minIndex = -1;
        int minValue = INT_MAX;
        for (int v = 0; v < n; v++) {
            if (!visited[v] && dist[v] < minValue) {
                minValue = dist[v];
                minIndex = v;
            }
        }

        if (minIndex == -1) break;
        visited[minIndex] = true;

        for (int v = 0; v < n; v++) {
            if (!visited[v] && obj->graph[minIndex][v] != INT_MAX) {
                int newDist = dist[minIndex] + obj->graph[minIndex][v];
                if (newDist < dist[v]) {
                    dist[v] = newDist;
                }
            }
        }
    }

    int result = (dist[end] == INT_MAX) ? -1 : dist[end];
    free(dist);
    free(visited);
    return result;
}

void graphFree(Graph* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->graph[i]);
    }
    free(obj->graph);
    free(obj);
}