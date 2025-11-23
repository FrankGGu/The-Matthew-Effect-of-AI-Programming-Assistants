#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int from;
    int to;
} Pair;

typedef struct Edge {
    int to;
    struct Edge* next;
} Edge;

typedef struct {
    Edge* adj[10000]; // Assuming max 10^4 unique nodes
} Graph;

void addEdge(Graph* graph, int from, int to) {
    Edge* edge = (Edge*)malloc(sizeof(Edge));
    edge->to = to;
    edge->next = graph->adj[from];
    graph->adj[from] = edge;
}

void freeGraph(Graph* graph) {
    for (int i = 0; i < 10000; i++) {
        Edge* current = graph->adj[i];
        while (current) {
            Edge* next = current->next;
            free(current);
            current = next;
        }
    }
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int getDegree(Graph* graph, int node) {
    int in = 0, out = 0;
    Edge* current = graph->adj[node];
    while (current) {
        out++;
        current = current->next;
    }
    for (int i = 0; i < 10000; i++) {
        current = graph->adj[i];
        while (current) {
            if (current->to == node)
                in++;
            current = current->next;
        }
    }
    return out - in;
}

void findEulerianPath(Graph* graph, int start, int* result, int* index) {
    Edge* current = graph->adj[start];
    while (current) {
        graph->adj[start] = current->next;
        findEulerianPath(graph, current->to, result, index);
        current = graph->adj[start];
    }
    result[*index] = start;
    (*index)++;
}

int* validArrangement(char*** pairs, int pairsSize, int* returnSize) {
    Graph graph;
    memset(&graph, 0, sizeof(Graph));

    int maxNode = 0;
    for (int i = 0; i < pairsSize; i++) {
        int from = atoi(pairs[i][0]);
        int to = atoi(pairs[i][1]);
        addEdge(&graph, from, to);
        if (from > maxNode) maxNode = from;
        if (to > maxNode) maxNode = to;
    }

    int start = 0;
    for (int i = 0; i <= maxNode; i++) {
        if (getDegree(&graph, i) == 1) {
            start = i;
            break;
        }
    }

    int* result = (int*)malloc(pairsSize * sizeof(int));
    int index = 0;
    findEulerianPath(&graph, start, result, &index);

    *returnSize = index;
    return result;
}