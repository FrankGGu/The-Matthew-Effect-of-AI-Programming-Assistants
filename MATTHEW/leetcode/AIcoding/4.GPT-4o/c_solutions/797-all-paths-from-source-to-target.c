#include <stdlib.h>

void backtrack(int** graph, int graphSize, int* graphColSize, int* path, int pathSize, int** result, int* returnSize, int* returnColumnSizes, int target, int node) {
    path[pathSize] = node;
    if (node == target) {
        result[*returnSize] = (int*)malloc((pathSize + 1) * sizeof(int));
        for (int i = 0; i <= pathSize; i++) {
            result[*returnSize][i] = path[i];
        }
        returnColumnSizes[*returnSize] = pathSize + 1;
        (*returnSize)++;
    } else {
        for (int i = 0; i < graph[node][0]; i++) {
            backtrack(graph, graphSize, graphColSize, path, pathSize + 1, result, returnSize, returnColumnSizes, target, graph[node][i + 1]);
        }
    }
}

int** allPathsSourceTarget(int** graph, int graphSize, int* graphColSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(1000 * sizeof(int*));
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(1000 * sizeof(int));
    int* path = (int*)malloc(graphSize * sizeof(int));
    backtrack(graph, graphSize, graphColSize, path, 0, result, returnSize, *returnColumnSizes, graphSize - 1, 0);
    free(path);
    return result;
}