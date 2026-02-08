typedef struct {
    int node;
    long long cost;
} Edge;

typedef struct {
    Edge *edges;
    int size;
    int capacity;
} Graph;

Graph* createGraph(int capacity) {
    Graph *graph = (Graph *)malloc(sizeof(Graph));
    graph->edges = (Edge *)malloc(sizeof(Edge) * capacity);
    graph->size = 0;
    graph->capacity = capacity;
    return graph;
}

void addEdge(Graph *graph, int node, long long cost) {
    if (graph->size < graph->capacity) {
        graph->edges[graph->size].node = node;
        graph->edges[graph->size].cost = cost;
        graph->size++;
    }
}

void dfs(int u, int parent, long long *dist, long long *maxDist, Graph **graph, int *visited) {
    visited[u] = 1;
    for (int i = 0; i < graph[u]->size; i++) {
        Edge edge = graph[u]->edges[i];
        if (edge.node != parent) {
            dist[edge.node] = dist[u] + edge.cost;
            if (dist[edge.node] > *maxDist) {
                *maxDist = dist[edge.node];
            }
            dfs(edge.node, u, dist, maxDist, graph, visited);
        }
    }
}

long long maxPathLength(int n, Graph **graph) {
    long long *dist = (long long *)calloc(n, sizeof(long long));
    long long maxDist = 0;
    int *visited = (int *)calloc(n, sizeof(int));
    dfs(0, -1, dist, &maxDist, graph, visited);
    int farthestNode = 0;
    for (int i = 0; i < n; i++) {
        if (dist[i] == maxDist) {
            farthestNode = i;
            break;
        }
    }
    free(dist);
    free(visited);

    dist = (long long *)calloc(n, sizeof(long long));
    maxDist = 0;
    visited = (int *)calloc(n, sizeof(int));
    dfs(farthestNode, -1, dist, &maxDist, graph, visited);

    free(dist);
    free(visited);
    return maxDist;
}

long long shortestPath(int n, int **edges, int edgesSize, int *edgesColSize) {
    Graph **graph = (Graph **)malloc(n * sizeof(Graph *));
    for (int i = 0; i < n; i++) {
        graph[i] = createGraph(n);
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1], w = edges[i][2];
        addEdge(graph[u], v, w);
        addEdge(graph[v], u, w);
    }

    long long result = maxPathLength(n, graph);

    for (int i = 0; i < n; i++) {
        free(graph[i]->edges);
        free(graph[i]);
    }
    free(graph);

    return result;
}