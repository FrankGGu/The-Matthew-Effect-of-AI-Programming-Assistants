#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumProfit(int n, int* profits, int profitsSize, int** edges, int edgesSize, int* edgesColSize) {
    int *inDegree = (int*)calloc(n, sizeof(int));
    int *dp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = profits[i];
    }

    for (int i = 0; i < edgesSize; i++) {
        inDegree[edges[i][1]]++;
    }

    int *queue = (int*)malloc(n * sizeof(int));
    int head = 0, tail = 0;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            queue[tail++] = i;
        }
    }

    while (head < tail) {
        int u = queue[head++];
        for (int i = 0; i < edgesSize; i++) {
            if (edges[i][0] == u) {
                int v = edges[i][1];
                dp[v] = fmax(dp[v], dp[u] + profits[v]);
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    queue[tail++] = v;
                }
            }
        }
    }

    int maxProfit = 0;
    for (int i = 0; i < n; i++) {
        maxProfit = fmax(maxProfit, dp[i]);
    }

    free(inDegree);
    free(dp);
    free(queue);

    return maxProfit;
}