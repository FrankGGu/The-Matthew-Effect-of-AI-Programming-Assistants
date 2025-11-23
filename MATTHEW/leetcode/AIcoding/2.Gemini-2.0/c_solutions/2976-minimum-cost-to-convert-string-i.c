#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minimumCost(char *source, char *target, char *original[], char *changed[], int *cost, int costSize) {
    int n = 26;
    long long dist[n][n];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i == j) {
                dist[i][j] = 0;
            } else {
                dist[i][j] = LLONG_MAX;
            }
        }
    }

    for (int i = 0; i < costSize; i++) {
        dist[original[i][0] - 'a'][changed[i][0] - 'a'] = cost[i];
    }

    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (dist[i][k] != LLONG_MAX && dist[k][j] != LLONG_MAX && dist[i][k] + dist[k][j] < dist[i][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }

    long long totalCost = 0;
    for (int i = 0; source[i] != '\0'; i++) {
        if (source[i] == target[i]) {
            continue;
        }

        long long currentCost = dist[source[i] - 'a'][target[i] - 'a'];
        if (currentCost == LLONG_MAX) {
            return -1;
        }

        totalCost += currentCost;
    }

    return totalCost;
}