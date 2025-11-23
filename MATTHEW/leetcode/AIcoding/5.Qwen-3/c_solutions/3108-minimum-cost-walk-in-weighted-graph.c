#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int node;
    int cost;
} NodeCost;

typedef struct {
    int* dist;
    int size;
} DijkstraResult;

DijkstraResult* dijkstra(int n, int** graph, int start) {
    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[start] = 0;

    NodeCost* heap = (NodeCost*)malloc(n * sizeof(NodeCost));
    int heapSize = 0;

    heap[heapSize].node = start;
    heap[heapSize++].cost = 0;

    while (heapSize > 0) {
        int minIndex = 0;
        for (int i = 1; i < heapSize; i++) {
            if (heap[i].cost < heap[minIndex].cost) {
                minIndex = i;
            }
        }

        NodeCost current = heap[minIndex];
        heap[minIndex] = heap[--heapSize];

        for (int i = 0; i < n; i++) {
            if (graph[current.node][i] != -1 && dist[i] > dist[current.node] + graph[current.node][i]) {
                dist[i] = dist[current.node] + graph[current.node][i];
                heap[heapSize].node = i;
                heap[heapSize++].cost = dist[i];
            }
        }
    }

    DijkstraResult* result = (DijkstraResult*)malloc(sizeof(DijkstraResult));
    result->dist = dist;
    result->size = n;
    return result;
}

int minCostWalk(int n, int** graph, int start, int end) {
    DijkstraResult* result = dijkstra(n, graph, start);
    int res = result->dist[end];
    free(result->dist);
    free(result);
    return res;
}