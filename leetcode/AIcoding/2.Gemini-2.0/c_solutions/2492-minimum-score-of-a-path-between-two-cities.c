#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INF 1000000000

typedef struct Edge {
    int to;
    int cost;
} Edge;

typedef struct Node {
    int city;
    int distance;
} Node;

int minScore(int n, int** roads, int roadsSize, int* roadsColSize) {
    int* distances = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        distances[i] = INF;
    }
    distances[0] = INF;

    int* visited = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    int queue[n];
    int head = 0, tail = 0;
    queue[tail++] = 0;
    visited[0] = 1;

    while (head < tail) {
        int u = queue[head++];

        for (int i = 0; i < roadsSize; i++) {
            if (roads[i][0] == u + 1) {
                int v = roads[i][1] - 1;
                int cost = roads[i][2];

                distances[0] = (distances[0] < cost) ? distances[0] : cost;

                if (!visited[v]) {
                    queue[tail++] = v;
                    visited[v] = 1;
                }
            } else if (roads[i][1] == u + 1) {
                int v = roads[i][0] - 1;
                int cost = roads[i][2];

                distances[0] = (distances[0] < cost) ? distances[0] : cost;

                if (!visited[v]) {
                    queue[tail++] = v;
                    visited[v] = 1;
                }
            }
        }
    }

    free(visited);
    free(distances);

    return distances[0];
}