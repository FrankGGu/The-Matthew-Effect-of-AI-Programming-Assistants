#include <stdlib.h>
#include <string.h>

void dfs(int** graph, int* graphColSize, int graphSize,
         int currentNode, int targetNode,
         int* currentPath, int pathLength,
         int*** resultPaths, int** resultColSizes,
         int* resultCount, int* resultCapacity) {

    currentPath[pathLength] = currentNode;
    pathLength++;

    if (currentNode == targetNode) {
        if (*resultCount == *resultCapacity) {
            *resultCapacity = (*resultCapacity == 0) ? 1 : (*resultCapacity * 2);
            *resultPaths = (int**)realloc(*resultPaths, sizeof(int*) * (*resultCapacity));
            *resultColSizes = (int*)realloc(*resultColSizes, sizeof(int) * (*resultCapacity));
        }

        (*resultPaths)[*resultCount] = (int*)malloc(sizeof(int) * pathLength);
        memcpy((*resultPaths)[*resultCount], currentPath, sizeof(int) * pathLength);
        (*resultColSizes)[*resultCount] = pathLength;
        (*resultCount)++;
        return;
    }

    for (int i = 0; i < graphColSize[currentNode]; i++) {
        int neighbor = graph[currentNode][i];
        dfs(graph, graphColSize, graphSize,
            neighbor, targetNode,
            currentPath, pathLength,
            resultPaths, resultColSizes,
            resultCount, resultCapacity);
    }
}

int** allPathsSourceTarget(int** graph, int graphSize, int* graphColSize, int* returnSize, int** returnColumnSizes) {
    int** resultPaths = NULL;
    int* resultColSizes = NULL;
    int resultCount = 0;
    int resultCapacity = 0;

    int* currentPath = (int*)malloc(sizeof(int) * graphSize);

    dfs(graph, graphColSize, graphSize,
        0, graphSize - 1,
        currentPath, 0,
        &resultPaths, &resultColSizes,
        &resultCount, &resultCapacity);

    free(currentPath);

    *returnSize = resultCount;
    *returnColumnSizes = resultColSizes;

    return resultPaths;
}