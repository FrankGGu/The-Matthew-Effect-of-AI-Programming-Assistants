#define MAX_N 10000

typedef struct {
    int node;
    int weight;
} Edge;

typedef struct {
    Edge* edges;
    int size;
    int capacity;
} AdjList;

AdjList graph[MAX_N];
int dp[MAX_N][2];

int max(int a, int b) {
    return a > b ? a : b;
}

void addEdge(int u, int v, int w) {
    if (graph[u].size == graph[u].capacity) {
        graph[u].capacity = graph[u].capacity == 0 ? 4 : graph[u].capacity * 2;
        graph[u].edges = realloc(graph[u].edges, graph[u].capacity * sizeof(Edge));
    }
    graph[u].edges[graph[u].size].node = v;
    graph[u].edges[graph[u].size].weight = w;
    graph[u].size++;
}

void dfs(int u, int parent, int k) {
    int first_max = 0, second_max = 0;

    for (int i = 0; i < graph[u].size; i++) {
        int v = graph[u].edges[i].node;
        int w = graph[u].edges[i].weight;
        if (v == parent) continue;

        dfs(v, u, k);

        int path_weight = dp[v][0] + w;
        if (path_weight > first_max) {
            second_max = first_max;
            first_max = path_weight;
        } else if (path_weight > second_max) {
            second_max = path_weight;
        }
    }

    dp[u][0] = first_max;
    if (k == 2) {
        dp[u][1] = first_max + second_max;
    }
}

int maxWeight(int** edges, int edgesSize, int* edgesColSize, int k) {
    int n = edgesSize + 1;

    for (int i = 0; i < n; i++) {
        graph[i].size = 0;
        graph[i].capacity = 0;
        graph[i].edges = NULL;
        dp[i][0] = 0;
        dp[i][1] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        addEdge(u, v, w);
        addEdge(v, u, w);
    }

    dfs(0, -1, k);

    int result = 0;
    for (int i = 0; i < n; i++) {
        if (k == 1) {
            result = max(result, dp[i][0]);
        } else {
            result = max(result, dp[i][1]);
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i].edges);
    }

    return result;
}