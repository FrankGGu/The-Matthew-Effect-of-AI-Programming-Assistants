#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCostConvertString(char* source, char* target, char* originalChar, char* changedChar, int* cost, int costSize) {
    int n = strlen(source);
    int m = strlen(target);
    if (n != m) return -1;

    int** graph = (int**)malloc(26 * sizeof(int*));
    for (int i = 0; i < 26; i++) {
        graph[i] = (int*)malloc(26 * sizeof(int));
        for (int j = 0; j < 26; j++) {
            graph[i][j] = (i == j) ? 0 : INT_MAX;
        }
    }

    for (int i = 0; i < costSize; i++) {
        int u = originalChar[i] - 'a';
        int v = changedChar[i] - 'a';
        if (cost[i] < graph[u][v]) {
            graph[u][v] = cost[i];
        }
    }

    for (int k = 0; k < 26; k++) {
        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < 26; j++) {
                if (graph[i][k] != INT_MAX && graph[k][j] != INT_MAX) {
                    graph[i][j] = fmin(graph[i][j], graph[i][k] + graph[k][j]);
                }
            }
        }
    }

    int totalCost = 0;
    for (int i = 0; i < n; i++) {
        int s = source[i] - 'a';
        int t = target[i] - 'a';
        if (s == t) continue;
        if (graph[s][t] == INT_MAX) return -1;
        totalCost += graph[s][t];
    }

    for (int i = 0; i < 26; i++) {
        free(graph[i]);
    }
    free(graph);

    return totalCost;
}