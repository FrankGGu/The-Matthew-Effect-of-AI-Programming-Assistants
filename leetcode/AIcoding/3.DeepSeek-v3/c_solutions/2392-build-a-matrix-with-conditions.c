#include <stdlib.h>
#include <string.h>

#define MAX_N 400

int* topoSort(int k, int** conditions, int conditionsSize, int* returnSize) {
    int* indegree = (int*)calloc(k + 1, sizeof(int));
    int** graph = (int**)malloc((k + 1) * sizeof(int*));
    for (int i = 0; i <= k; i++) {
        graph[i] = (int*)malloc((k + 1) * sizeof(int));
        memset(graph[i], 0, (k + 1) * sizeof(int));
    }

    for (int i = 0; i < conditionsSize; i++) {
        int u = conditions[i][0];
        int v = conditions[i][1];
        if (graph[u][v] == 0) {
            graph[u][v] = 1;
            indegree[v]++;
        }
    }

    int* queue = (int*)malloc(k * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 1; i <= k; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int* order = (int*)malloc(k * sizeof(int));
    int idx = 0;

    while (front < rear) {
        int u = queue[front++];
        order[idx++] = u;

        for (int v = 1; v <= k; v++) {
            if (graph[u][v]) {
                indegree[v]--;
                if (indegree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }

    *returnSize = idx;

    for (int i = 0; i <= k; i++) {
        free(graph[i]);
    }
    free(graph);
    free(indegree);
    free(queue);

    return order;
}

int** buildMatrix(int k, int** rowConditions, int rowConditionsSize, int* rowConditionsColSize, int** colConditions, int colConditionsSize, int* colConditionsColSize, int* returnSize, int** returnColumnSizes) {
    int rowSize, colSize;
    int* rowOrder = topoSort(k, rowConditions, rowConditionsSize, &rowSize);
    int* colOrder = topoSort(k, colConditions, colConditionsSize, &colSize);

    if (rowSize != k || colSize != k) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        free(rowOrder);
        free(colOrder);
        return NULL;
    }

    int** res = (int**)malloc(k * sizeof(int*));
    *returnColumnSizes = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        res[i] = (int*)calloc(k, sizeof(int));
        (*returnColumnSizes)[i] = k;
    }

    int* rowPos = (int*)malloc((k + 1) * sizeof(int));
    int* colPos = (int*)malloc((k + 1) * sizeof(int));

    for (int i = 0; i < k; i++) {
        rowPos[rowOrder[i]] = i;
        colPos[colOrder[i]] = i;
    }

    for (int i = 1; i <= k; i++) {
        res[rowPos[i]][colPos[i]] = i;
    }

    free(rowOrder);
    free(colOrder);
    free(rowPos);
    free(colPos);

    *returnSize = k;
    return res;
}