#define MAXN 100

bool dfs(int node, int *visited, int **graph, int graphSize, int *graphColSize) {
    if (visited[node] != 0) return visited[node] == 1;
    visited[node] = 2; // mark as visiting
    for (int i = 0; i < graphColSize[node]; i++) {
        int neighbor = graph[node][i];
        if (!dfs(neighbor, visited, graph, graphSize, graphColSize)) {
            return false;
        }
    }
    visited[node] = 1; // mark as visited
    return true;
}

int* eventualSafeNodes(int** graph, int graphSize, int* graphColSize, int* returnSize) {
    int *visited = (int*)malloc(graphSize * sizeof(int));
    for (int i = 0; i < graphSize; i++) {
        visited[i] = 0;
    }

    for (int i = 0; i < graphSize; i++) {
        dfs(i, visited, graph, graphSize, graphColSize);
    }

    int *result = (int*)malloc(graphSize * sizeof(int));
    int count = 0;
    for (int i = 0; i < graphSize; i++) {
        if (visited[i] == 1) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    free(visited);
    return result;
}