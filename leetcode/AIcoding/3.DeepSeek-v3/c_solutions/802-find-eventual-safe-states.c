/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* eventualSafeNodes(int** graph, int graphSize, int* graphColSize, int* returnSize) {
    int* color = (int*)calloc(graphSize, sizeof(int));
    int* result = (int*)malloc(graphSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < graphSize; i++) {
        if (dfs(graph, graphSize, graphColSize, color, i)) {
            result[(*returnSize)++] = i;
        }
    }

    free(color);
    return result;
}

int dfs(int** graph, int graphSize, int* graphColSize, int* color, int node) {
    if (color[node] > 0) {
        return color[node] == 2;
    }

    color[node] = 1;
    for (int i = 0; i < graphColSize[node]; i++) {
        int next = graph[node][i];
        if (color[next] == 2) continue;
        if (color[next] == 1 || !dfs(graph, graphSize, graphColSize, color, next)) {
            return 0;
        }
    }

    color[node] = 2;
    return 1;
}