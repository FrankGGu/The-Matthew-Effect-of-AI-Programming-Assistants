#include <stdbool.h>
#include <stdlib.h>

bool* checkIfPrerequisite(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = numCourses;
    bool** reachable = (bool**)malloc(n * sizeof(bool*));
    for (int i = 0; i < n; ++i) {
        reachable[i] = (bool*)malloc(n * sizeof(bool));
        for (int j = 0; j < n; ++j) {
            reachable[i][j] = false;
        }
    }

    for (int i = 0; i < prerequisitesSize; ++i) {
        int u = prerequisites[i][0];
        int v = prerequisites[i][1];
        reachable[u][v] = true;
    }

    for (int k = 0; k < n; ++k) {
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (reachable[i][k] && reachable[k][j]) {
                    reachable[i][j] = true;
                }
            }
        }
    }

    *returnSize = queriesSize;
    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; ++i) {
        int u = queries[i][0];
        int v = queries[i][1];
        result[i] = reachable[u][v];
    }

    for (int i = 0; i < n; ++i) {
        free(reachable[i]);
    }
    free(reachable);

    return result;
}