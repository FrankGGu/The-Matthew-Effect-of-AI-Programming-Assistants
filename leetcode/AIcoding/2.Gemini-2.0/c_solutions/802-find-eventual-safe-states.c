#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* eventualSafeNodes(int** graph, int graphSize, int* graphColSize, int* returnSize){
    int* safe = (int*)malloc(sizeof(int) * graphSize);
    int* visited = (int*)malloc(sizeof(int) * graphSize);
    int* inStack = (int*)malloc(sizeof(int) * graphSize);

    for (int i = 0; i < graphSize; i++) {
        safe[i] = 0;
        visited[i] = 0;
        inStack[i] = 0;
    }

    bool isCyclic(int node) {
        visited[node] = 1;
        inStack[node] = 1;

        for (int i = 0; i < graphColSize[node]; i++) {
            int neighbor = graph[node][i];
            if (!visited[neighbor]) {
                if (isCyclic(neighbor)) {
                    return true;
                }
            } else if (inStack[neighbor]) {
                return true;
            }
        }

        inStack[node] = 0;
        return false;
    }

    for (int i = 0; i < graphSize; i++) {
        if (!visited[i]) {
            isCyclic(i);
        }
    }

    *returnSize = 0;
    int* result = (int*)malloc(sizeof(int) * graphSize);
    for (int i = 0; i < graphSize; i++) {
        if (!inStack[i]) {
            result[(*returnSize)++] = i;
            safe[i] = 1;
        }
    }

    free(visited);
    free(inStack);

    return result;
}