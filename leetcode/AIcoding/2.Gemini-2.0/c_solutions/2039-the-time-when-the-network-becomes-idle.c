#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int networkBecomesIdle(int** edges, int edgesSize, int* edgesColSize, int* patience, int patienceSize) {
    int n = patienceSize;
    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[0] = 0;

    int* queue = (int*)malloc(n * sizeof(int));
    int head = 0, tail = 0;
    queue[tail++] = 0;

    while (head < tail) {
        int u = queue[head++];
        for (int i = 0; i < edgesSize; i++) {
            int v = -1;
            if (edges[i][0] == u) {
                v = edges[i][1];
            } else if (edges[i][1] == u) {
                v = edges[i][0];
            }

            if (v != -1 && dist[v] == INT_MAX) {
                dist[v] = dist[u] + 1;
                queue[tail++] = v;
            }
        }
    }

    int maxTime = 0;
    for (int i = 1; i < n; i++) {
        int travelTime = 2 * dist[i];
        int lastSendTime = (travelTime / patience[i]) * patience[i];
        if (lastSendTime == travelTime) {
            lastSendTime -= patience[i];
        }
        int returnTime = lastSendTime + travelTime;
        if (returnTime > maxTime) {
            maxTime = returnTime;
        }
    }

    free(dist);
    free(queue);
    return maxTime + 1;
}