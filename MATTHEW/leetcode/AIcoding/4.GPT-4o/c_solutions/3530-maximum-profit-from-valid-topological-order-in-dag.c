#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* edges;
    int* profits;
    int size;
} Graph;

int maxProfit(int* profit, int profitSize, int** edges, int edgesSize, int* edgesColSize) {
    int* indegree = (int*)calloc(profitSize, sizeof(int));
    int* dp = (int*)calloc(profitSize, sizeof(int));
    Graph graph = {0};

    for (int i = 0; i < edgesSize; i++) {
        indegree[edges[i][0]]++;
    }

    for (int i = 0; i < profitSize; i++) {
        dp[i] = profit[i];
    }

    for (int i = 0; i < edgesSize; i++) {
        if (!graph.edges) {
            graph.edges = (int*)malloc(edgesSize * 2 * sizeof(int));
            graph.size = edgesSize * 2;
        }
        graph.edges[i*2] = edges[i][0];
        graph.edges[i*2 + 1] = edges[i][1];
    }

    for (int i = 0; i < profitSize; i++) {
        if (indegree[i] == 0) {
            dp[i] = profit[i];
        }
    }

    for (int i = 0; i < profitSize; i++) {
        for (int j = 0; j < edgesSize; j++) {
            if (graph.edges[j*2] == i) {
                dp[graph.edges[j*2 + 1]] = fmax(dp[graph.edges[j*2 + 1]], dp[i] + profit[graph.edges[j*2 + 1]]);
            }
        }
    }

    int max_profit = 0;
    for (int i = 0; i < profitSize; i++) {
        max_profit = fmax(max_profit, dp[i]);
    }

    free(indegree);
    free(dp);
    free(graph.edges);

    return max_profit;
}