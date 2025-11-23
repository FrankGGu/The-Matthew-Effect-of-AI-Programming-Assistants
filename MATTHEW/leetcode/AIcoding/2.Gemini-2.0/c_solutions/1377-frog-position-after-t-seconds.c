#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double frogPosition(int n, int** edges, int edgesSize, int* edgesColSize, int t, int target) {
    if (n == 1) return 1.0;

    bool adj[n + 1][n + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            adj[i][j] = false;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        adj[edges[i][0]][edges[i][1]] = true;
        adj[edges[i][1]][edges[i][0]] = true;
    }

    double prob[n + 1];
    for (int i = 1; i <= n; i++) {
        prob[i] = 0.0;
    }
    prob[1] = 1.0;

    bool visited[n + 1];
    for (int i = 1; i <= n; i++) {
        visited[i] = false;
    }
    visited[1] = true;

    int q[n + 1];
    int front = 0, rear = 0;
    q[rear++] = 1;

    for (int time = 0; time < t; time++) {
        int qSize = rear - front;
        for (int i = 0; i < qSize; i++) {
            int u = q[front++];
            int count = 0;
            for (int v = 1; v <= n; v++) {
                if (adj[u][v] && !visited[v]) {
                    count++;
                }
            }
            if (count == 0) continue;

            for (int v = 1; v <= n; v++) {
                if (adj[u][v] && !visited[v]) {
                    prob[v] = prob[u] / count;
                    visited[v] = true;
                    q[rear++] = v;
                }
            }
            prob[u] = 0.0;
        }
    }

    return prob[target];
}