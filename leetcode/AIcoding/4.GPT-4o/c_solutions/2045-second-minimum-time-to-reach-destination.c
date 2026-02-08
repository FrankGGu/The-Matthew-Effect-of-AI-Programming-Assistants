#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int node;
    long time;
} Node;

int cmp(const void *a, const void *b) {
    return ((Node *)a)->time - ((Node *)b)->time;
}

long secondMinimum(int n, int** edges, int edgesSize, int* edgesColSize) {
    long **graph = (long **)malloc(n * sizeof(long *));
    for (int i = 0; i < n; i++) {
        graph[i] = (long *)malloc(n * sizeof(long));
        for (int j = 0; j < n; j++) {
            graph[i][j] = LONG_MAX;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0] - 1][edges[i][1] - 1] = edges[i][2];
        graph[edges[i][1] - 1][edges[i][0] - 1] = edges[i][2];
    }

    long *first = (long *)malloc(n * sizeof(long));
    long *second = (long *)malloc(n * sizeof(long));
    for (int i = 0; i < n; i++) {
        first[i] = LONG_MAX;
        second[i] = LONG_MAX;
    }
    first[0] = 0;

    Node *pq = (Node *)malloc(n * sizeof(Node));
    int pqSize = 0;
    pq[pqSize++] = (Node){0, 0};

    while (pqSize > 0) {
        qsort(pq, pqSize, sizeof(Node), cmp);
        Node curr = pq[0];
        pqSize--;
        for (int i = 0; i < pqSize; i++) {
            pq[i] = pq[i + 1];
        }

        for (int j = 0; j < n; j++) {
            if (graph[curr.node][j] == LONG_MAX) continue;
            long newTime = curr.time + graph[curr.node][j];

            if (newTime < first[j]) {
                second[j] = first[j];
                first[j] = newTime;
                pq[pqSize++] = (Node){j, newTime};
            } else if (newTime < second[j] && newTime != first[j]) {
                second[j] = newTime;
                pq[pqSize++] = (Node){j, newTime};
            }
        }
    }

    long result = second[n - 1];
    free(first);
    free(second);
    free(pq);
    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);

    return result == LONG_MAX ? -1 : result;
}