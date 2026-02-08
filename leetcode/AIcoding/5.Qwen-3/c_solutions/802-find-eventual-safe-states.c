#include <stdio.h>
#include <stdlib.h>

int* eventualSafeStates(int** graph, int graphSize, int* graphColSize, int* returnSize) {
    int n = graphSize;
    int* color = (int*)malloc(n * sizeof(int));
    int* result = NULL;
    int resultSize = 0;

    for (int i = 0; i < n; i++) {
        color[i] = 0;
    }

    int* stack = (int*)malloc(n * sizeof(int));
    int top = -1;

    for (int i = 0; i < n; i++) {
        if (color[i] == 0) {
            int* visited = (int*)malloc(n * sizeof(int));
            for (int j = 0; j < n; j++) {
                visited[j] = 0;
            }
            int isCycle = 0;
            int* tempStack = (int*)malloc(n * sizeof(int));
            int tempTop = -1;
            tempStack[++tempTop] = i;
            visited[i] = 1;

            while (tempTop >= 0) {
                int node = tempStack[tempTop];
                int hasUnvisited = 0;
                for (int j = 0; j < graphColSize[node]; j++) {
                    int neighbor = graph[node][j];
                    if (visited[neighbor] == 0) {
                        visited[neighbor] = 1;
                        tempStack[++tempTop] = neighbor;
                        hasUnvisited = 1;
                        break;
                    } else if (visited[neighbor] == 1) {
                        isCycle = 1;
                        break;
                    }
                }
                if (!hasUnvisited) {
                    tempTop--;
                    if (isCycle) {
                        for (int k = 0; k <= tempTop; k++) {
                            visited[tempStack[k]] = 2;
                        }
                    } else {
                        for (int k = 0; k <= tempTop; k++) {
                            visited[tempStack[k]] = 2;
                        }
                    }
                }
            }

            free(visited);
            free(tempStack);
        }
    }

    for (int i = 0; i < n; i++) {
        if (color[i] == 2) {
            resultSize++;
        }
    }

    result = (int*)malloc(resultSize * sizeof(int));
    int index = 0;
    for (int i = 0; i < n; i++) {
        if (color[i] == 2) {
            result[index++] = i;
        }
    }

    *returnSize = resultSize;
    free(color);
    free(stack);
    return result;
}