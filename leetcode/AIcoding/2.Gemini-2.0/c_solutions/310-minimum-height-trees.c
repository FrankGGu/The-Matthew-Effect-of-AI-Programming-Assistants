#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findMinHeightTrees(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    if (n == 1) {
        int* result = (int*)malloc(sizeof(int));
        result[0] = 0;
        *returnSize = 1;
        return result;
    }

    int* degree = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        degree[i] = 0;
    }

    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            adj[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][v] = 1;
        adj[v][u] = 1;
        degree[u]++;
        degree[v]++;
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int head = 0;
    int tail = 0;

    for (int i = 0; i < n; i++) {
        if (degree[i] == 1) {
            queue[tail++] = i;
        }
    }

    int count = n;
    while (count > 2) {
        int size = tail - head;
        count -= size;
        for (int i = 0; i < size; i++) {
            int u = queue[head++];
            degree[u] = 0;
            for (int v = 0; v < n; v++) {
                if (adj[u][v] == 1) {
                    adj[u][v] = 0;
                    adj[v][u] = 0;
                    degree[v]--;
                    if (degree[v] == 1) {
                        queue[tail++] = v;
                    }
                }
            }
        }
    }

    int* result = (int*)malloc((tail - head) * sizeof(int));
    int index = 0;
    for (int i = head; i < tail; i++) {
        result[index++] = queue[i];
    }

    *returnSize = tail - head;

    free(degree);
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(queue);

    return result;
}