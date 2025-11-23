#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** allPathsSourceTarget(int** graph, int graphSize, int* graphColSize, int* returnSize, int** returnColumnSizes){
    int target = graphSize - 1;
    int** result = (int**)malloc(sizeof(int*) * 10000);
    *returnColumnSizes = (int*)malloc(sizeof(int) * 10000);
    *returnSize = 0;

    int* path = (int*)malloc(sizeof(int) * graphSize);
    int pathIndex = 0;
    path[pathIndex++] = 0;

    void backtrack(int node) {
        if (node == target) {
            result[*returnSize] = (int*)malloc(sizeof(int) * pathIndex);
            (*returnColumnSizes)[*returnSize] = pathIndex;
            for (int i = 0; i < pathIndex; i++) {
                result[*returnSize][i] = path[i];
            }
            (*returnSize)++;
            return;
        }

        for (int i = 0; i < graphColSize[node]; i++) {
            int nextNode = graph[node][i];
            path[pathIndex++] = nextNode;
            backtrack(nextNode);
            pathIndex--;
        }
    }

    backtrack(0);
    free(path);
    return result;
}