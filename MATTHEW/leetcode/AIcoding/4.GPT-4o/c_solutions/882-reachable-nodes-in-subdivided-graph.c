#define MAX_NODES 10001
#define INF 0x3f3f3f3f

typedef struct {
    int to, weight;
} Edge;

typedef struct {
    Edge edges[100];
    int size;
} Graph;

Graph graph[MAX_NODES];
int dist[MAX_NODES];
bool visited[MAX_NODES];

void addEdge(int u, int v, int w) {
    graph[u].edges[graph[u].size++] = (Edge){v, w};
    graph[v].edges[graph[v].size++] = (Edge){u, w};
}

int reachableNodes(int** edges, int edgesSize, int* edgesColSize, int limit, int start, int target) {
    for (int i = 0; i < MAX_NODES; i++) {
        graph[i].size = 0;
        dist[i] = INF;
        visited[i] = false;
    }

    for (int i = 0; i < edgesSize; i++) {
        addEdge(edges[i][0], edges[i][1], edges[i][2]);
    }

    dist[start] = 0;
    int reachableCount = 0;

    for (int i = 0; i < MAX_NODES; i++) {
        int node = -1;
        for (int j = 0; j < MAX_NODES; j++) {
            if (!visited[j] && (node == -1 || dist[j] < dist[node])) {
                node = j;
            }
        }
        if (node == -1 || dist[node] > limit) break;
        visited[node] = true;
        reachableCount++;

        for (int j = 0; j < graph[node].size; j++) {
            Edge edge = graph[node].edges[j];
            if (dist[node] + edge.weight < dist[edge.to]) {
                dist[edge.to] = dist[node] + edge.weight;
            }
        }
    }

    return reachableCount;
}