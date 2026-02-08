#define MAXN 100

int** allPathsSourceTarget(int** graph, int graphSize, int* graphColSize, int* returnSize, int** returnColumnSizes) {
    int target = graphSize - 1;
    int** result = (int**)malloc(MAXN * sizeof(int*));
    *returnColumnSizes = (int*)malloc(MAXN * sizeof(int));
    *returnSize = 0;

    int* path = (int*)malloc(graphSize * sizeof(int));
    int pathIndex = 0;

    void backtrack(int node) {
        path[pathIndex++] = node;
        if (node == target) {
            result[*returnSize] = (int*)malloc(pathIndex * sizeof(int));
            memcpy(result[*returnSize], path, pathIndex * sizeof(int));
            (*returnColumnSizes)[*returnSize] = pathIndex;
            (*returnSize)++;
        } else {
            for (int i = 0; i < graphColSize[node]; i++) {
                backtrack(graph[node][i]);
            }
        }
        pathIndex--;
    }

    backtrack(0);
    free(path);
    return result;
}