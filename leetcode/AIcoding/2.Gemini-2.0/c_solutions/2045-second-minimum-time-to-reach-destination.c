#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 5005
#define INF 1e9

struct QueueNode {
    int node;
    int time;
};

int secondMinimum(int n, int** edges, int edgesSize, int* edgesColSize, int time, int change) {
    int adj[n + 1][n + 1];
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            adj[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        adj[edges[i][0]][edges[i][1]] = 1;
        adj[edges[i][1]][edges[i][0]] = 1;
    }

    int dist[n + 1][2];
    for (int i = 1; i <= n; i++) {
        dist[i][0] = dist[i][1] = INF;
    }

    dist[1][0] = 0;

    struct QueueNode queue[MAXN * 2];
    int head = 0, tail = 0;

    queue[tail].node = 1;
    queue[tail].time = 0;
    tail++;

    while (head < tail) {
        int u = queue[head].node;
        int t = queue[head].time;
        head++;

        for (int v = 1; v <= n; v++) {
            if (adj[u][v]) {
                if (t + time < dist[v][0]) {
                    dist[v][1] = dist[v][0];
                    dist[v][0] = t + time;

                    queue[tail].node = v;
                    queue[tail].time = t + time;
                    tail++;
                } else if (t + time > dist[v][0] && t + time < dist[v][1]) {
                    dist[v][1] = t + time;
                    queue[tail].node = v;
                    queue[tail].time = t + time;
                    tail++;
                }
            }
        }
    }

    int ans = dist[n][1];
    int cur_time = 0;
    for (int i = 0; i < ans / time; i++) {
        int period = cur_time / change;
        if (period % 2 == 1) {
            cur_time = (period + 1) * change;
        }
        cur_time += time;
    }
    return cur_time;
}