#include <string.h>
#include <limits.h>

#define INF (LLONG_MAX / 2)

long long minimumCost(char* source, char* target, char* original, char* changed, int* cost, int kSize) {
    long long dist[26][26];

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            if (i == j) {
                dist[i][j] = 0;
            } else {
                dist[i][j] = INF;
            }
        }
    }

    for (int i = 0; i < kSize; i++) {
        int u = original[i] - 'a';
        int v = changed[i] - 'a';
        if ((long long)cost[i] < dist[u][v]) {
            dist[u][v] = (long long)cost[i];
        }
    }

    for (int k = 0; k < 26; k++) {
        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < 26; j++) {
                if (dist[i][k] != INF && dist[k][j] != INF) {
                    if (dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }
    }

    long long total_cost = 0;
    int len = strlen(source);

    for (int i = 0; i < len; i++) {
        if (source[i] != target[i]) {
            int u = source[i] - 'a';
            int v = target[i] - 'a';
            if (dist[u][v] == INF) {
                return -1;
            }
            total_cost += dist[u][v];
        }
    }

    return total_cost;
}