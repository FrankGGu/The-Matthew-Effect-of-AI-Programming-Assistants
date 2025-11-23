#define MOD 1000000007

typedef struct {
    int node;
    int weight;
} Edge;

typedef struct {
    Edge *edges;
    int size;
} Graph;

int cmp(const void *a, const void *b) {
    return ((Edge *)a)->weight - ((Edge *)b)->weight;
}

Graph* createGraph(int n, int** edges, int edgesSize, int* edgesColSize) {
    Graph *graph = malloc(n * sizeof(Graph));
    for (int i = 0; i < n; i++) {
        graph[i].edges = malloc(edgesSize * sizeof(Edge));
        graph[i].size = 0;
    }
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] - 1;
        int v = edges[i][1] - 1;
        int w = edges[i][2];
        graph[u].edges[graph[u].size++] = (Edge){v, w};
        graph[v].edges[graph[v].size++] = (Edge){u, w};
    }
    return graph;
}

long long dijkstra(int n, Graph *graph) {
    long long *dist = malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) dist[i] = LLONG_MAX;
    dist[0] = 0;
    bool *visited = calloc(n, sizeof(bool));

    for (int i = 0; i < n; i++) {
        int u = -1;
        for (int j = 0; j < n; j++) {
            if (!visited[j] && (u == -1 || dist[j] < dist[u])) {
                u = j;
            }
        }
        visited[u] = true;
        for (int j = 0; j < graph[u].size; j++) {
            int v = graph[u].edges[j].node;
            long long weight = graph[u].edges[j].weight;
            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
            }
        }
    }

    long long *count = malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) count[i] = 0;
    count[n - 1] = 1;

    for (int i = n - 1; i >= 0; i--) {
        for (int j = 0; j < graph[i].size; j++) {
            int v = graph[i].edges[j].node;
            if (dist[i] > dist[v]) {
                count[i] = (count[i] + count[v]) % MOD;
            }
        }
    }

    long long result = count[0];
    free(dist);
    free(count);
    free(visited);
    return result;
}

int countRestrictedPaths(int n, int** edges, int edgesSize, int* edgesColSize) {
    Graph *graph = createGraph(n, edges, edgesSize, edgesColSize);
    long long result = dijkstra(n, graph);
    for (int i = 0; i < n; i++) {
        free(graph[i].edges);
    }
    free(graph);
    return (int)(result % MOD);
}