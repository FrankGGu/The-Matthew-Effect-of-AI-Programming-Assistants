#define MAX_NODES 1000
#define MAX_VALUES 10

int maxQuality;

typedef struct {
    int node;
    int time;
} Edge;

typedef struct {
    Edge* edges;
    int size;
    int capacity;
} AdjList;

void dfs(int node, int currentTime, int currentValue, int maxTime, int* values, AdjList* graph, int* visited) {
    if (currentTime > maxTime) return;

    int temp = visited[node];
    visited[node]++;

    if (visited[node] == 1) {
        currentValue += values[node];
    }

    if (node == 0) {
        if (currentValue > maxQuality) {
            maxQuality = currentValue;
        }
    }

    for (int i = 0; i < graph[node].size; i++) {
        Edge e = graph[node].edges[i];
        dfs(e.node, currentTime + e.time, currentValue, maxTime, values, graph, visited);
    }

    visited[node] = temp;
}

int maximalPathQuality(int* values, int valuesSize, int** edges, int edgesSize, int* edgesColSize, int maxTime) {
    maxQuality = 0;
    AdjList graph[MAX_NODES];
    int visited[MAX_NODES] = {0};

    for (int i = 0; i < valuesSize; i++) {
        graph[i].edges = malloc(10 * sizeof(Edge));
        graph[i].size = 0;
        graph[i].capacity = 10;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int time = edges[i][2];

        if (graph[u].size >= graph[u].capacity) {
            graph[u].capacity *= 2;
            graph[u].edges = realloc(graph[u].edges, graph[u].capacity * sizeof(Edge));
        }
        graph[u].edges[graph[u].size].node = v;
        graph[u].edges[graph[u].size].time = time;
        graph[u].size++;

        if (graph[v].size >= graph[v].capacity) {
            graph[v].capacity *= 2;
            graph[v].edges = realloc(graph[v].edges, graph[v].capacity * sizeof(Edge));
        }
        graph[v].edges[graph[v].size].node = u;
        graph[v].edges[graph[v].size].time = time;
        graph[v].size++;
    }

    dfs(0, 0, 0, maxTime, values, graph, visited);

    for (int i = 0; i < valuesSize; i++) {
        free(graph[i].edges);
    }

    return maxQuality;
}