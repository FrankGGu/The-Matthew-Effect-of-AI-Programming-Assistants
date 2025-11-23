#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int node;
    int cost;
} Edge;

typedef struct {
    Edge* edges;
    int size;
} Graph;

Graph* createGraph(int n) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->edges = (Edge*)malloc(n * sizeof(Edge));
    graph->size = 0;
    return graph;
}

void addEdge(Graph* graph, int u, int v) {
    graph->edges[graph->size].node = v;
    graph->edges[graph->size].cost = 0; 
    graph->size++;
}

void addReverseEdge(Graph* graph, int u, int v) {
    graph->edges[graph->size].node = v;
    graph->edges[graph->size].cost = 1; 
    graph->size++;
}

int minEdgeReversals(int n, int** edges, int edgesSize, int* edgesColSize) {
    Graph* graph = createGraph(n);
    for (int i = 0; i < edgesSize; i++) {
        addEdge(graph, edges[i][0], edges[i][1]);
        addReverseEdge(graph, edges[i][1], edges[i][0]);
    }

    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) dist[i] = INT_MAX;
    dist[0] = 0;

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;
    queue[rear++] = 0;

    while (front < rear) {
        int curr = queue[front++];
        for (int i = 0; i < graph->size; i++) {
            if (graph->edges[i].node == curr) {
                int newCost = dist[curr] + graph->edges[i].cost;
                if (newCost < dist[graph->edges[i].node]) {
                    dist[graph->edges[i].node] = newCost;
                    queue[rear++] = graph->edges[i].node;
                }
            }
        }
    }

    int result = dist[n - 1] == INT_MAX ? -1 : dist[n - 1];
    free(dist);
    free(queue);
    free(graph->edges);
    free(graph);
    return result;
}