#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int dest;
    int price;
} Edge;

typedef struct {
    int city;
    int stops;
    int cost;
} Node;

int cmp(const void *a, const void *b) {
    return ((Node *)a)->cost - ((Node *)b)->cost;
}

int findCheapestPrice(int n, int** flights, int flightsSize, int* flightsColSize, int src, int dst, int K) {
    Edge** graph = (Edge**)malloc(n * sizeof(Edge*));
    for (int i = 0; i < n; i++) {
        graph[i] = (Edge*)malloc(n * sizeof(Edge));
        for (int j = 0; j < n; j++) {
            graph[i][j].dest = -1;
            graph[i][j].price = INT_MAX;
        }
    }

    for (int i = 0; i < flightsSize; i++) {
        int u = flights[i][0];
        int v = flights[i][1];
        int p = flights[i][2];
        graph[u][v].dest = v;
        graph[u][v].price = p;
    }

    int minCost = INT_MAX;
    Node* heap = (Node*)malloc(n * sizeof(Node));
    int heapSize = 0;

    heap[heapSize++] = (Node){src, 0, 0};

    while (heapSize > 0) {
        qsort(heap, heapSize, sizeof(Node), cmp);
        Node current = heap[0];
        heap[0] = heap[--heapSize];

        if (current.city == dst) {
            minCost = current.cost < minCost ? current.cost : minCost;
            continue;
        }

        if (current.stops > K) continue;

        for (int i = 0; i < n; i++) {
            if (graph[current.city][i].dest != -1) {
                int newCost = current.cost + graph[current.city][i].price;
                if (newCost < INT_MAX) {
                    heap[heapSize++] = (Node){i, current.stops + 1, newCost};
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(heap);

    return minCost == INT_MAX ? -1 : minCost;
}