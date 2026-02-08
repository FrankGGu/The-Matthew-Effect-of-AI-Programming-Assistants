#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct Edge {
    int to;
    double prob;
    struct Edge* next;
} Edge;

typedef struct {
    int size;
    Edge** adj;
} Graph;

Graph* createGraph(int n) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->size = n;
    graph->adj = (Edge**)calloc(n, sizeof(Edge*));
    return graph;
}

void addEdge(Graph* graph, int from, int to, double prob) {
    Edge* edge = (Edge*)malloc(sizeof(Edge));
    edge->to = to;
    edge->prob = prob;
    edge->next = graph->adj[from];
    graph->adj[from] = edge;
}

double maxProbability(int n, int** edges, int edgesSize, int* edgesColSize, int* succProb, int succProbSize, int start, int end) {
    double* prob = (double*)calloc(n, sizeof(double));
    prob[start] = 1.0;

    for (int i = 0; i < n - 1; i++) {
        int updated = 0;
        for (int j = 0; j < edgesSize; j++) {
            int u = edges[j][0];
            int v = edges[j][1];
            double p = succProb[j];
            if (prob[u] * p > prob[v]) {
                prob[v] = prob[u] * p;
                updated = 1;
            }
            if (prob[v] * p > prob[u]) {
                prob[u] = prob[v] * p;
                updated = 1;
            }
        }
        if (!updated) break;
    }

    return prob[end];
}