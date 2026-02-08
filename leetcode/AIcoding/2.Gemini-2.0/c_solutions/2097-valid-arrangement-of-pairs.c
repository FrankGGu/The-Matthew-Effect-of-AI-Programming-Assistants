#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int key;
    int val;
} Pair;

int cmp(const void *a, const void *b) {
    return ((Pair*)a)->key - ((Pair*)b)->key;
}

int** findItinerary(int** pairs, int pairsSize, int* pairsColSize, int* returnSize, int** returnColumnSizes) {
    int* inDegree = calloc(1001, sizeof(int));
    int* outDegree = calloc(1001, sizeof(int));
    int start = pairs[0][0];
    int maxVal = 0;

    for (int i = 0; i < pairsSize; i++) {
        outDegree[pairs[i][0]]++;
        inDegree[pairs[i][1]]++;
        if (outDegree[pairs[i][0]] == 1 && pairs[i][0] < start) {
            start = pairs[i][0];
        }
        if (pairs[i][0] > maxVal) maxVal = pairs[i][0];
        if (pairs[i][1] > maxVal) maxVal = pairs[i][1];
    }

    int startFound = 0;
    for (int i = 0; i <= maxVal; i++) {
        if (outDegree[i] - inDegree[i] == 1) {
            start = i;
            startFound = 1;
            break;
        }
    }

    if (!startFound) {
       for (int i = 0; i <= maxVal; i++) {
            if (outDegree[i] > 0) {
                start = i;
                break;
            }
        }
    }

    int** adjList = calloc(1001, sizeof(int*));
    int* adjSizes = calloc(1001, sizeof(int));
    for (int i = 0; i <= maxVal; i++) {
        adjList[i] = calloc(pairsSize + 1, sizeof(int));
    }

    for (int i = 0; i < pairsSize; i++) {
        adjList[pairs[i][0]][adjSizes[pairs[i][0]]++] = pairs[i][1];
    }

    for (int i = 0; i <= maxVal; i++) {
        qsort(adjList[i], adjSizes[i], sizeof(int), cmp);
    }

    int** result = malloc(pairsSize * sizeof(int*));
    *returnColumnSizes = malloc(pairsSize * sizeof(int));
    *returnSize = 0;

    int* stack = malloc((pairsSize + 1) * sizeof(int));
    int stackSize = 0;
    stack[stackSize++] = start;

    int* path = malloc((pairsSize + 1) * sizeof(int));
    int pathIndex = 0;

    while (stackSize > 0) {
        int u = stack[--stackSize];
        if (adjSizes[u] == 0) {
            path[pathIndex++] = u;
        } else {
            stack[stackSize++] = u;
            int v = adjList[u][0];
            for (int i = 0; i < adjSizes[u] - 1; i++) {
                adjList[u][i] = adjList[u][i + 1];
            }
            adjSizes[u]--;
            stack[stackSize++] = v;
        }
    }

    for (int i = pairsSize - 1; i >= 0; i--) {
        result[*returnSize] = malloc(2 * sizeof(int));
        (*returnColumnSizes)[*returnSize] = 2;
        result[*returnSize][0] = path[i + 1];
        result[*returnSize][1] = path[i];
        (*returnSize)++;
    }

    free(inDegree);
    free(outDegree);
    for (int i = 0; i <= maxVal; i++) {
        free(adjList[i]);
    }
    free(adjList);
    free(adjSizes);
    free(stack);
    free(path);

    return result;
}