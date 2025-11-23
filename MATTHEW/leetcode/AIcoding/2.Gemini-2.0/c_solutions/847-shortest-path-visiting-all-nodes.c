#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shortestPathLength(int** graph, int graphSize, int* graphColSize){
    int n = graphSize;
    int target = (1 << n) - 1;
    int queue[n * (1 << n)][2];
    int dist[n][1 << n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < (1 << n); j++) {
            dist[i][j] = -1;
        }
    }

    int head = 0, tail = 0;
    for (int i = 0; i < n; i++) {
        queue[tail][0] = i;
        queue[tail][1] = 1 << i;
        dist[i][1 << i] = 0;
        tail++;
    }

    while (head < tail) {
        int u = queue[head][0];
        int mask = queue[head][1];
        head++;

        for (int i = 0; i < graphColSize[u]; i++) {
            int v = graph[u][i];
            int newMask = mask | (1 << v);

            if (dist[v][newMask] == -1) {
                dist[v][newMask] = dist[u][mask] + 1;
                queue[tail][0] = v;
                queue[tail][1] = newMask;
                tail++;
            }
        }
    }

    int ans = INT_MAX;
    for (int i = 0; i < n; i++) {
        if (dist[i][target] != -1) {
            ans = (ans < dist[i][target]) ? ans : dist[i][target];
        }
    }

    return ans;
}