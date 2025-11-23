typedef struct {
    int node;
    int weight;
} Edge;

typedef struct {
    Edge* edges;
    int size;
    int capacity;
} AdjList;

int maximumWeight(int n, int** edges, int edgesSize, int* edgesColSize) {
    AdjList* graph = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        graph[i].edges = (Edge*)malloc(4 * sizeof(Edge));
        graph[i].size = 0;
        graph[i].capacity = 4;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        if (graph[u].size == graph[u].capacity) {
            graph[u].capacity *= 2;
            graph[u].edges = (Edge*)realloc(graph[u].edges, graph[u].capacity * sizeof(Edge));
        }
        graph[u].edges[graph[u].size].node = v;
        graph[u].edges[graph[u].size].weight = w;
        graph[u].size++;

        if (graph[v].size == graph[v].capacity) {
            graph[v].capacity *= 2;
            graph[v].edges = (Edge*)realloc(graph[v].edges, graph[v].capacity * sizeof(Edge));
        }
        graph[v].edges[graph[v].size].node = u;
        graph[v].edges[graph[v].size].weight = w;
        graph[v].size++;
    }

    int* degree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        degree[i] = graph[i].size;
    }

    int* visited = (int*)calloc(n, sizeof(int));
    int* maxEdge = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        maxEdge[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < graph[i].size; j++) {
            if (graph[i].edges[j].weight > maxEdge[i]) {
                maxEdge[i] = graph[i].edges[j].weight;
            }
        }
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        if (degree[i] % 2 == 1) {
            result += maxEdge[i];
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i].edges);
    }
    free(graph);
    free(degree);
    free(visited);
    free(maxEdge);

    return result;
}