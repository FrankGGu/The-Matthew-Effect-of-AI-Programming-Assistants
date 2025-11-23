bool isBipartite(int** graph, int graphSize, int* graphColSize) {
    int* color = (int*)malloc(graphSize * sizeof(int));
    for (int i = 0; i < graphSize; i++) color[i] = -1;

    for (int start = 0; start < graphSize; start++) {
        if (color[start] == -1) {
            color[start] = 0;
            int queueSize = 1;
            int* queue = (int*)malloc(graphSize * sizeof(int));
            queue[0] = start;

            for (int j = 0; j < queueSize; j++) {
                int node = queue[j];
                for (int k = 0; k < graphColSize[node]; k++) {
                    int neighbor = graph[node][k];
                    if (color[neighbor] == -1) {
                        color[neighbor] = 1 - color[node];
                        queue[queueSize++] = neighbor;
                    } else if (color[neighbor] == color[node]) {
                        free(queue);
                        free(color);
                        return false;
                    }
                }
            }
            free(queue);
        }
    }
    free(color);
    return true;
}