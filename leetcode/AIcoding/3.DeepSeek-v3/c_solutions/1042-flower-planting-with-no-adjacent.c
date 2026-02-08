int* gardenNoAdj(int n, int** paths, int pathsSize, int* pathsColSize, int* returnSize) {
    int* res = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) res[i] = 0;

    int** graph = (int**)malloc(n * sizeof(int*));
    int* graphSize = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(3 * sizeof(int));
    }

    for (int i = 0; i < pathsSize; i++) {
        int u = paths[i][0] - 1;
        int v = paths[i][1] - 1;
        graph[u][graphSize[u]++] = v;
        graph[v][graphSize[v]++] = u;
    }

    for (int i = 0; i < n; i++) {
        int used[5] = {0};
        for (int j = 0; j < graphSize[i]; j++) {
            int neighbor = graph[i][j];
            used[res[neighbor]] = 1;
        }
        for (int color = 1; color <= 4; color++) {
            if (!used[color]) {
                res[i] = color;
                break;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphSize);

    *returnSize = n;
    return res;
}