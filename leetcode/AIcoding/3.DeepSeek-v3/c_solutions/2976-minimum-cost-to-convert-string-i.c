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

void addEdge(AdjList* adj, int to, ll cost) {
    if (adj->size >= adj->capacity) {
        adj->capacity = adj->capacity == 0 ? 4 : adj->capacity * 2;
        adj->edges = realloc(adj->edges, adj->capacity * sizeof(Edge));
    }
    adj->edges[adj->size].node = to;
    adj->edges[adj->size].cost = cost;
    adj->size++;
}

long long* dijkstra(int n, AdjList* graph, int start) {
    long long* dist = malloc(n * sizeof(long long));
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
            ll cost = graph[u].edges[k].cost;
            if (!visited[v] && dist[u] + cost < dist[v]) {
                dist[v] = dist[u] + cost;
            }
        }
    }

    free(visited);
    return dist;
}

long long minimumCost(char* source, char* target, char* original, char* changed, int* cost, int costSize) {
    AdjList graph[26];
    for (int i = 0; i < 26; i++) {
        graph[i].edges = NULL;
        graph[i].size = 0;
        graph[i].capacity = 0;
    }

    for (int i = 0; i < costSize; i++) {
        int from = original[i] - 'a';
        int to = changed[i] - 'a';
        addEdge(&graph[from], to, cost[i]);
    }

    long long* dist[26];
    for (int i = 0; i < 26; i++) {
        dist[i] = dijkstra(26, graph, i);
    }

    long long total = 0;
    int len = strlen(source);
    for (int i = 0; i < len; i++) {
        int s = source[i] - 'a';
        int t = target[i] - 'a';
        if (s == t) continue;
        if (dist[s][t] == LLONG_MAX) return -1;
        total += dist[s][t];
    }

    for (int i = 0; i < 26; i++) {
        free(dist[i]);
        free(graph[i].edges);
    }

    return total;
}