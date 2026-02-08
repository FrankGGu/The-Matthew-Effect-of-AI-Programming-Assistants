int sumOfDistancesInTree(int N, int** edges, int edgesSize, int* edgesColSize) {
    int* count = (int*)calloc(N, sizeof(int));
    int* result = (int*)calloc(N, sizeof(int));
    int** graph = (int**)malloc(N * sizeof(int*));
    for (int i = 0; i < N; i++) {
        graph[i] = (int*)malloc(N * sizeof(int));
        for (int j = 0; j < N; j++) {
            graph[i][j] = -1;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]][edges[i][1]] = 1;
        graph[edges[i][1]][edges[i][0]] = 1;
    }

    void dfs1(int node, int parent) {
        count[node] = 1;
        for (int i = 0; i < N; i++) {
            if (graph[node][i] == 1 && i != parent) {
                dfs1(i, node);
                count[node] += count[i];
                result[node] += result[i] + count[i];
            }
        }
    }

    void dfs2(int node, int parent) {
        for (int i = 0; i < N; i++) {
            if (graph[node][i] == 1 && i != parent) {
                result[i] = result[node] - count[i] + (N - count[i]);
                dfs2(i, node);
            }
        }
    }

    dfs1(0, -1);
    dfs2(0, -1);

    free(count);
    for (int i = 0; i < N; i++) {
        free(graph[i]);
    }
    free(graph);

    return result;
}