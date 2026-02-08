#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100

typedef struct {
    int to;
    int cost;
} Edge;

typedef struct {
    Edge *edges[MAXN];
    int edgeCount;
} Graph;

Graph* createGraph() {
    Graph *graph = (Graph*)malloc(sizeof(Graph));
    graph->edgeCount = 0;
    for (int i = 0; i < MAXN; i++) {
        graph->edges[i] = NULL;
    }
    return graph;
}

void addEdge(Graph *graph, int from, int to, int cost) {
    Edge *edge = (Edge*)malloc(sizeof(Edge));
    edge->to = to;
    edge->cost = cost;
    graph->edges[graph->edgeCount++] = edge;
}

int* solve(int n, int[][] edges, int edgesSize, int* edgesColSize, int[][] queries, int queriesSize, int* queriesColSize, int* returnSize) {
    Graph *graph = createGraph();
    for (int i = 0; i < edgesSize; i++) {
        addEdge(graph, edges[i][0], edges[i][1], edges[i][2]);
    }

    int *result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int start = queries[i][0];
        int end = queries[i][1];
        int k = queries[i][2];

        bool found = false;
        int queue[MAXN];
        int queueFront = 0;
        int queueRear = 0;
        int dist[MAXN];
        for (int j = 0; j < n; j++) {
            dist[j] = -1;
        }

        queue[queueRear++] = start;
        dist[start] = 0;

        while (queueFront < queueRear) {
            int u = queue[queueFront++];

            for (int j = 0; j < graph->edgeCount; j++) {
                if (edges[j][0] == u) {
                    int v = edges[j][1];
                    int weight = edges[j][2];

                    if (dist[v] == -1 || dist[v] > dist[u] + weight) {
                        dist[v] = dist[u] + weight;
                        queue[queueRear++] = v;
                    }
                }
            }
        }

        if (dist[end] != -1 && dist[end] <= k) {
            result[i] = 1;
        } else {
            result[i] = 0;
        }
    }

    return result;
}