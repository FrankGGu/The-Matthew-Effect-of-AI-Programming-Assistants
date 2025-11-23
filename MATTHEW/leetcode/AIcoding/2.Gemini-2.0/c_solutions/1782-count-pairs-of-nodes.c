#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countPairs(int n, int** edges, int edgesSize, int* edgesColSize, int* queries, int queriesSize, int* returnSize) {
    int* degree = (int*)malloc(sizeof(int) * (n + 1));
    for (int i = 0; i <= n; i++) {
        degree[i] = 0;
    }
    int* cnt = (int*)malloc(sizeof(int) * (n + 1));
    for (int i = 0; i <= n; i++) {
        cnt[i] = 0;
    }
    int overlap[n + 1][n + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            overlap[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        degree[u]++;
        degree[v]++;
        if (u > v) {
            int temp = u;
            u = v;
            v = temp;
        }
        overlap[u][v]++;
    }

    int* sortedDegree = (int*)malloc(sizeof(int) * (n + 1));
    for(int i = 1; i <= n; i++){
        sortedDegree[i] = degree[i];
    }

    qsort(sortedDegree + 1, n, sizeof(int), [](const void *a, const void *b) {
        return (*(int*)a - *(int*)b);
    });

    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int query = queries[i];
        int count = 0;
        for (int j = 1; j <= n; j++) {
            for (int k = j + 1; k <= n; k++) {
                if (degree[j] + degree[k] - overlap[j][k] > query) {
                    count++;
                }
            }
        }
        ans[i] = count;
    }

    free(degree);
    free(cnt);
    free(sortedDegree);
    return ans;
}