#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int node;
    int mask;
} State;

int shortestPathLength(int** graph, int graphSize, int* graphColSize) {
    int n = graphSize;
    int fullMask = (1 << n) - 1;
    int** dist = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dist[i] = (int*)malloc((1 << n) * sizeof(int));
        for (int j = 0; j < (1 << n); j++) {
            dist[i][j] = INT_MAX;
        }
    }

    State queue[1 << 20];
    int head = 0, tail = 0;

    for (int i = 0; i < n; i++) {
        queue[tail++] = (State){i, 1 << i};
        dist[i][1 << i] = 0;
    }

    while (head < tail) {
        State current = queue[head++];
        int u = current.node;
        int mask = current.mask;
        int d = dist[u][mask];

        for (int v = 0; v < graphColSize[u]; v++) {
            int next = graph[u][v];
            int nextMask = mask | (1 << next);
            if (dist[next][nextMask] > d + 1) {
                dist[next][nextMask] = d + 1;
                queue[tail++] = (State){next, nextMask};
            }
        }
    }

    int result = INT_MAX;
    for (int i = 0; i < n; i++) {
        result = result < dist[i][fullMask] ? result : dist[i][fullMask];
    }

    for (int i = 0; i < n; i++) {
        free(dist[i]);
    }
    free(dist);

    return result;
}