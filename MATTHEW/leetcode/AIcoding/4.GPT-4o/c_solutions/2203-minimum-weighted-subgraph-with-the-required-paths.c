#define MAXN 100005
#define INF 0x3f3f3f3f

typedef struct {
    int to, weight;
} Edge;

typedef struct {
    Edge edges[MAXN];
    int head[MAXN];
    int next[MAXN];
    int edgeCount;
} Graph;

Graph graph;
int dist[MAXN];
int n, m, k, start, end, required[MAXN];

void addEdge(int u, int v, int w) {
    graph.edges[graph.edgeCount].to = v;
    graph.edges[graph.edgeCount].weight = w;
    graph.next[graph.edgeCount] = graph.head[u];
    graph.head[u] = graph.edgeCount++;
}

void dijkstra(int source) {
    for (int i = 1; i <= n; i++) dist[i] = INF;
    dist[source] = 0;
    int visited[MAXN] = {0};
    for (int i = 1; i <= n; i++) {
        int u = -1;
        for (int j = 1; j <= n; j++) {
            if (!visited[j] && (u == -1 || dist[j] < dist[u])) u = j;
        }
        visited[u] = 1;
        for (int j = graph.head[u]; j != -1; j = graph.next[j]) {
            int v = graph.edges[j].to;
            if (dist[u] + graph.edges[j].weight < dist[v]) {
                dist[v] = dist[u] + graph.edges[j].weight;
            }
        }
    }
}

int minWeightedSubgraph(int** edges, int edgesSize, int* edgesColSize, int* requiredPaths, int requiredPathsSize) {
    n = edgesSize + 1;
    graph.edgeCount = 0;
    for (int i = 0; i < n; i++) {
        graph.head[i] = -1;
    }

    for (int i = 0; i < edgesSize; i++) {
        addEdge(edges[i][0], edges[i][1], edges[i][2]);
        addEdge(edges[i][1], edges[i][0], edges[i][2]);
    }

    for (int i = 0; i < requiredPathsSize; i++) {
        required[i] = requiredPaths[i];
    }

    int totalWeight = 0;
    for (int i = 0; i < requiredPathsSize; i++) {
        start = required[i];
        end = (i == requiredPathsSize - 1) ? required[0] : required[i + 1];
        dijkstra(start);
        if (dist[end] == INF) return -1;
        totalWeight += dist[end];
    }

    return totalWeight;
}