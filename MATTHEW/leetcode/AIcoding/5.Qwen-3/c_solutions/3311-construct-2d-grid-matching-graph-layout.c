#include <stdio.h>
#include <stdlib.h>

int** createGraph(int** items, int itemsSize, int* itemsColSize, int* returnSize, int** returnColumnSizes) {
    int n = itemsSize;
    int** graph = (int**)malloc(n * sizeof(int*));
    *returnSize = n;
    *returnColumnSizes = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        int count = 0;
        for (int j = 0; j < itemsColSize[i]; j++) {
            if (items[i][j] == -1) continue;
            count++;
        }
        (*returnColumnSizes)[i] = count;
        graph[i] = (int*)malloc(count * sizeof(int));
        int idx = 0;
        for (int j = 0; j < itemsColSize[i]; j++) {
            if (items[i][j] == -1) continue;
            graph[i][idx++] = items[i][j];
        }
    }

    return graph;
}