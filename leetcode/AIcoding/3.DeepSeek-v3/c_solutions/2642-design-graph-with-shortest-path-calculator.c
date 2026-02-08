typedef struct {
    int n;
    int** graph;
} Graph;

Graph* graphCreate(int n, int** edges, int edgesSize, int* edgesColSize) {
    Graph* obj = (Graph*)malloc(sizeof(Graph));
    obj->n = n;
    obj->graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        obj->graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            obj->graph[i][j] = (i == j) ? 0 : INT_MAX;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int from = edges[i][0];
        int to = edges[i][1];
        int cost = edges[i][2];
        obj->graph[from][to] = cost;
    }

    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (obj->graph[i][k] != INT_MAX && obj->graph[k][j] != INT_MAX) {
                    if (obj->graph[i][j] > obj->graph[i][k] + obj->graph[k][j]) {
                        obj->graph[i][j] = obj->graph[i][k] + obj->graph[k][j];
                    }
                }
            }
        }
    }

    return obj;
}

void graphAddEdge(Graph* obj, int* edge, int edgeSize) {
    int from = edge[0];
    int to = edge[1];
    int cost = edge[2];

    if (obj->graph[from][to] <= cost) {
        return;
    }

    obj->graph[from][to] = cost;
    int n = obj->n;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (obj->graph[i][from] != INT_MAX && obj->graph[to][j] != INT_MAX) {
                if (obj->graph[i][j] > obj->graph[i][from] + cost + obj->graph[to][j]) {
                    obj->graph[i][j] = obj->graph[i][from] + cost + obj->graph[to][j];
                }
            }
        }
    }
}

int graphShortestPath(Graph* obj, int node1, int node2) {
    return obj->graph[node1][node2] == INT_MAX ? -1 : obj->graph[node1][node2];
}

void graphFree(Graph* obj) {
    for (int i = 0; i < obj->n; i++) {
        free(obj->graph[i]);
    }
    free(obj->graph);
    free(obj);
}