#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* neighbors;
    int size;
} Node;

bool* checkIfPrerequisite(int n, int** prerequisites, int prerequisitesSize, int* queries, int queriesSize) {
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int u = prerequisites[i][0];
        int v = prerequisites[i][1];
        graph[u][v] = 1;
    }

    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (graph[i][k] && graph[k][j]) {
                    graph[i][j] = 1;
                }
            }
        }
    }

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i];
        int v = queries[i + 1];
        result[i] = graph[u][v];
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    return result;
}