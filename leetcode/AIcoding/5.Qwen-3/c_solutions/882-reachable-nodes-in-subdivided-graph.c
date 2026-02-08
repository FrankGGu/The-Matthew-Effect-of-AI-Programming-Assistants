#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct Edge {
    int to;
    int weight;
    struct Edge* next;
} Edge;

typedef struct {
    Edge* adj;
} Graph;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int reachableNodes(int** edges, int edgesSize, int* edgesColSize, int S, int M) {
    Graph* graph = (Graph*)malloc((edgesSize + 1) * sizeof(Graph));
    for (int i = 0; i <= edgesSize; i++) {
        graph[i].adj = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        Edge* newEdge = (Edge*)malloc(sizeof(Edge));
        newEdge->to = v;
        newEdge->weight = w;
        newEdge->next = graph[u].adj;
        graph[u].adj = newEdge;

        newEdge = (Edge*)malloc(sizeof(Edge));
        newEdge->to = u;
        newEdge->weight = w;
        newEdge->next = graph[v].adj;
        graph[v].adj = newEdge;
    }

    int* dist = (int*)malloc((edgesSize + 1) * sizeof(int));
    for (int i = 0; i <= edgesSize; i++) {
        dist[i] = INT_MAX;
    }
    dist[S] = 0;

    int* queue = (int*)malloc((edgesSize + 1) * sizeof(int));
    int front = 0, rear = 0;
    queue[rear++] = S;

    while (front < rear) {
        int u = queue[front++];
        Edge* e = graph[u].adj;
        while (e) {
            if (dist[e->to] > dist[u] + e->weight) {
                dist[e->to] = dist[u] + e->weight;
                queue[rear++] = e->to;
            }
            e = e->next;
        }
    }

    int count = 0;
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        if (dist[u] + w <= M || dist[v] + w <= M) {
            count++;
        }
    }

    free(dist);
    free(queue);
    for (int i = 0; i <= edgesSize; i++) {
        Edge* e = graph[i].adj;
        while (e) {
            Edge* next = e->next;
            free(e);
            e = next;
        }
    }
    free(graph);

    return count;
}