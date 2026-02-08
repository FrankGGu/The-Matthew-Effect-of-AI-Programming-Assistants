typedef struct {
    int u, v;
} Edge;

typedef struct {
    Edge* edges;
    int size;
} Result;

int time;
int* disc;
int* low;
int** res;
int resSize;

void dfs(int node, int parent, int** graph, int graphSize, int* graphColSize) {
    disc[node] = low[node] = ++time;

    for (int i = 0; i < graphColSize[node]; i++) {
        int neighbor = graph[node][i];
        if (neighbor == parent) continue;
        if (disc[neighbor] == -1) {
            dfs(neighbor, node, graph, graphSize, graphColSize);
            low[node] = fmin(low[node], low[neighbor]);
            if (low[neighbor] > disc[node]) {
                res[resSize] = (int*)malloc(2 * sizeof(int));
                res[resSize][0] = node;
                res[resSize][1] = neighbor;
                resSize++;
            }
        } else {
            low[node] = fmin(low[node], disc[neighbor]);
        }
    }
}

int** criticalConnections(int n, int** connections, int connectionsSize, int* connectionsColSize, int* returnSize, int** returnColumnSizes) {
    int** graph = (int**)malloc(n * sizeof(int*));
    int* graphColSize = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        graphColSize[i] = 0;
        graph[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < connectionsSize; i++) {
        int u = connections[i][0];
        int v = connections[i][1];
        graph[u][graphColSize[u]++] = v;
        graph[v][graphColSize[v]++] = u;
    }

    disc = (int*)malloc(n * sizeof(int));
    low = (int*)malloc(n * sizeof(int));
    res = (int**)malloc(connectionsSize * sizeof(int*));
    resSize = 0;
    time = 0;

    for (int i = 0; i < n; i++) {
        disc[i] = -1;
        low[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        if (disc[i] == -1) {
            dfs(i, -1, graph, n, graphColSize);
        }
    }

    *returnSize = resSize;
    *returnColumnSizes = (int*)malloc(resSize * sizeof(int));
    for (int i = 0; i < resSize; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    for (int i = 0; i < resSize; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphColSize);
    free(disc);
    free(low);

    return res;
}