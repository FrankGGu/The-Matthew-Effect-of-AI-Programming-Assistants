#include <stdio.h>
#include <stdlib.h>

int** allPathsSourceTarget(int** graph, int graphSize, int* graphColSize, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    int** path = (int**)malloc(sizeof(int*));
    path[0] = (int*)malloc(sizeof(int));
    path[0][0] = 0;
    int pathLen = 1;

    int** stack = (int**)malloc(sizeof(int*));
    stack[0] = (int*)malloc(sizeof(int) * pathLen);
    for (int i = 0; i < pathLen; i++) stack[0][i] = path[0][i];
    int stackSize = 1;

    while (stackSize > 0) {
        int* currentPath = stack[stackSize - 1];
        int currentLen = pathLen;
        int currentNode = currentPath[currentLen - 1];

        if (currentNode == graphSize - 1) {
            (*returnSize)++;
            *returnColumnSizes = (int*)realloc(*returnColumnSizes, sizeof(int) * (*returnSize));
            (*returnColumnSizes)[*returnSize - 1] = currentLen;

            result = (int**)realloc(result, sizeof(int*) * (*returnSize));
            result[*returnSize - 1] = (int*)malloc(sizeof(int) * currentLen);
            for (int i = 0; i < currentLen; i++) result[*returnSize - 1][i] = currentPath[i];
        }

        for (int i = 0; i < graphColSize[currentNode]; i++) {
            int nextNode = graph[currentNode][i];
            int* newPath = (int*)malloc(sizeof(int) * (currentLen + 1));
            for (int j = 0; j < currentLen; j++) newPath[j] = currentPath[j];
            newPath[currentLen] = nextNode;

            stack = (int**)realloc(stack, sizeof(int*) * (stackSize + 1));
            stack[stackSize++] = newPath;
        }

        free(currentPath);
        stackSize--;
    }

    free(stack);
    free(path[0]);
    free(path);

    return result;
}