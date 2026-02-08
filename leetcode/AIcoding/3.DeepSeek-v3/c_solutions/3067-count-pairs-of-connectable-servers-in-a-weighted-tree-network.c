/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* countPairsOfConnectableServers(int** edges, int edgesSize, int* edgesColSize, int signalSpeed, int* returnSize) {
    int n = edgesSize + 1;
    int* res = calloc(n, sizeof(int));
    *returnSize = n;

    // Build adjacency list
    int** graph = malloc(n * sizeof(int*));
    int* graphSize = calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        graph[i] = malloc(2 * n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        graph[u][graphSize[u] * 2] = v;
        graph[u][graphSize[u] * 2 + 1] = w;
        graphSize[u]++;

        graph[v][graphSize[v] * 2] = u;
        graph[v][graphSize[v] * 2 + 1] = w;
        graphSize[v]++;
    }

    void dfs(int node, int parent, int dist, int* count) {
        if (dist % signalSpeed == 0) {
            (*count)++;
        }
        for (int i = 0; i < graphSize[node]; i++) {
            int neighbor = graph[node][i * 2];
            int weight = graph[node][i * 2 + 1];
            if (neighbor != parent) {
                dfs(neighbor, node, dist + weight, count);
            }
        }
    }

    for (int c = 0; c < n; c++) {
        int total = 0;
        int* counts = calloc(graphSize[c], sizeof(int));

        for (int i = 0; i < graphSize[c]; i++) {
            int neighbor = graph[c][i * 2];
            int weight = graph[c][i * 2 + 1];
            int count = 0;
            dfs(neighbor, c, weight, &count);
            counts[i] = count;
        }

        for (int i = 0; i < graphSize[c]; i++) {
            for (int j = i + 1; j < graphSize[c]; j++) {
                res[c] += counts[i] * counts[j];
            }
        }

        free(counts);
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphSize);

    return res;
}