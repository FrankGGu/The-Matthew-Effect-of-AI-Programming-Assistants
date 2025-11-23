#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct Edge {
    int to;
    int weight;
    struct Edge* next;
} Edge;

typedef struct {
    Edge* head;
} AdjList;

int compare(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int maxKEdges(int n, int** edges, int edgesSize, int k) {
    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].head = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        Edge* newEdge = (Edge*)malloc(sizeof(Edge));
        newEdge->to = v;
        newEdge->weight = w;
        newEdge->next = adj[u].head;
        adj[u].head = newEdge;

        newEdge = (Edge*)malloc(sizeof(Edge));
        newEdge->to = u;
        newEdge->weight = w;
        newEdge->next = adj[v].head;
        adj[v].head = newEdge;
    }

    int* maxWeights = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        maxWeights[i] = INT_MIN;
    }

    for (int i = 0; i < n; i++) {
        Edge* current = adj[i].head;
        int* weights = (int*)malloc(k * sizeof(int));
        int count = 0;
        while (current && count < k) {
            weights[count++] = current->weight;
            current = current->next;
        }
        qsort(weights, count, sizeof(int), compare);
        if (count > 0) {
            maxWeights[i] = weights[0];
        }
        free(weights);
    }

    int result = INT_MIN;
    for (int i = 0; i < n; i++) {
        if (maxWeights[i] != INT_MIN) {
            result = (result > maxWeights[i]) ? result : maxWeights[i];
        }
    }

    for (int i = 0; i < n; i++) {
        Edge* current = adj[i].head;
        while (current) {
            Edge* next = current->next;
            free(current);
            current = next;
        }
    }
    free(adj);
    free(maxWeights);

    return result;
}