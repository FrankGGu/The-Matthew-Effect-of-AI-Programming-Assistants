typedef long long ll;

typedef struct {
    int node;
    ll cost;
} Edge;

typedef struct {
    Edge* edges;
    int size;
    int capacity;
} AdjList;

void addEdge(AdjList* adj, int node, ll cost) {
    if (adj->size == adj->capacity) {
        adj->capacity = adj->capacity == 0 ? 4 : adj->capacity * 2;
        adj->edges = realloc(adj->edges, adj->capacity * sizeof(Edge));
    }
    adj->edges[adj->size].node = node;
    adj->edges[adj->size].cost = cost;
    adj->size++;
}

void dijkstra(int n, int start, AdjList* graph, ll* dist) {
    for (int i = 0; i < n; i++) dist[i] = LLONG_MAX;
    dist[start] = 0;

    int* visited = calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        int u = -1;
        for (int j = 0; j < n; j++) {
            if (!visited[j] && (u == -1 || dist[j] < dist[u])) {
                u = j;
            }
        }
        if (u == -1 || dist[u] == LLONG_MAX) break;
        visited[u] = 1;

        for (int k = 0; k < graph[u].size; k++) {
            int v = graph[u].edges[k].node;
            ll w = graph[u].edges[k].cost;
            if (!visited[v] && dist[u] + w < dist[v]) {
                dist[v] = dist[u] + w;
            }
        }
    }
    free(visited);
}

long long minimumWeight(int n, int** edges, int edgesSize, int* edgesColSize, int src1, int src2, int dest) {
    AdjList* graph = malloc(n * sizeof(AdjList));
    AdjList* reverseGraph = malloc(n * sizeof(AdjList));

    for (int i = 0; i < n; i++) {
        graph[i].edges = NULL;
        graph[i].size = 0;
        graph[i].capacity = 0;
        reverseGraph[i].edges = NULL;
        reverseGraph[i].size = 0;
        reverseGraph[i].capacity = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        ll w = edges[i][2];
        addEdge(&graph[u], v, w);
        addEdge(&reverseGraph[v], u, w);
    }

    ll* dist1 = malloc(n * sizeof(ll));
    ll* dist2 = malloc(n * sizeof(ll));
    ll* distDest = malloc(n * sizeof(ll));

    dijkstra(n, src1, graph, dist1);
    dijkstra(n, src2, graph, dist2);
    dijkstra(n, dest, reverseGraph, distDest);

    ll result = LLONG_MAX;
    for (int i = 0; i < n; i++) {
        if (dist1[i] != LLONG_MAX && dist2[i] != LLONG_MAX && distDest[i] != LLONG_MAX) {
            ll total = dist1[i] + dist2[i] + distDest[i];
            if (total < result) result = total;
        }
    }

    for (int i = 0; i < n; i++) {
        if (graph[i].edges) free(graph[i].edges);
        if (reverseGraph[i].edges) free(reverseGraph[i].edges);
    }
    free(graph);
    free(reverseGraph);
    free(dist1);
    free(dist2);
    free(distDest);

    return result == LLONG_MAX ? -1 : result;
}