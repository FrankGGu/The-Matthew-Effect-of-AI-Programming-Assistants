#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumCost(char *source, char *target, char *originalChar, char *changedChar, int cost[], int sourceSize, int targetSize, int originalCharSize) {
    int** dist = (int**)malloc(26 * sizeof(int*));
    for (int i = 0; i < 26; i++) {
        dist[i] = (int*)malloc(26 * sizeof(int));
        for (int j = 0; j < 26; j++) {
            dist[i][j] = (i == j) ? 0 : 1000000;
        }
    }

    for (int i = 0; i < originalCharSize; i++) {
        int u = originalChar[i] - 'a';
        int v = changedChar[i] - 'a';
        if (dist[u][v] > cost[i]) {
            dist[u][v] = cost[i];
        }
    }

    for (int k = 0; k < 26; k++) {
        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < 26; j++) {
                if (dist[i][k] + dist[k][j] < dist[i][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }

    int totalCost = 0;
    for (int i = 0; i < sourceSize; i++) {
        if (source[i] == target[i]) continue;
        int u = source[i] - 'a';
        int v = target[i] - 'a';
        if (dist[u][v] == 1000000) return -1;
        totalCost += dist[u][v];
    }

    for (int i = 0; i < 26; i++) {
        free(dist[i]);
    }
    free(dist);

    return totalCost;
}