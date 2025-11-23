bool bfs(int node, int* color, int** graph, int graphSize, int* graphColSize) {
    int queue[10000], front = 0, back = 0;
    queue[back++] = node;
    color[node] = 1;

    while (front < back) {
        int curr = queue[front++];
        for (int i = 0; i < graphColSize[curr]; i++) {
            int neighbor = graph[curr][i];
            if (color[neighbor] == 0) {
                color[neighbor] = -color[curr];
                queue[back++] = neighbor;
            } else if (color[neighbor] == color[curr]) {
                return false;
            }
        }
    }
    return true;
}

bool isBipartite(int** graph, int graphSize, int* graphColSize) {
    int* color = (int*)malloc(graphSize * sizeof(int));
    for (int i = 0; i < graphSize; i++) {
        color[i] = 0;
    }

    for (int i = 0; i < graphSize; i++) {
        if (color[i] == 0) {
            if (!bfs(i, color, graph, graphSize, graphColSize)) {
                free(color);
                return false;
            }
        }
    }

    free(color);
    return true;
}