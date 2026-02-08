#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100
#define INF 20000

int* shortestAlternatingPaths(int n, int** redEdges, int redEdgesSize, int* redEdgesColSize, int** blueEdges, int blueEdgesSize, int* blueEdgesColSize, int* returnSize) {
    int red_adj[MAXN][MAXN] = {0};
    int blue_adj[MAXN][MAXN] = {0};

    for (int i = 0; i < redEdgesSize; i++) {
        red_adj[redEdges[i][0]][redEdges[i][1]] = 1;
    }

    for (int i = 0; i < blueEdgesSize; i++) {
        blue_adj[blueEdges[i][0]][blueEdges[i][1]] = 1;
    }

    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = INF;
    }
    result[0] = 0;

    int queue[2 * MAXN * MAXN];
    int head = 0, tail = 0;

    int visited[MAXN][2] = {0}; 
    visited[0][0] = 1;
    visited[0][1] = 1;

    queue[tail++] = 0;
    queue[tail++] = -1; 
    queue[tail++] = 0; 

    while (head < tail) {
        int node = queue[head++];
        int color = queue[head++];
        int dist = queue[head++];

        if (color == -1 || color == 0) {
            for (int i = 0; i < n; i++) {
                if (red_adj[node][i] == 1 && visited[i][0] == 0) {
                    result[i] = (result[i] > dist + 1) ? dist + 1 : result[i];
                    queue[tail++] = i;
                    queue[tail++] = 1;
                    queue[tail++] = dist + 1;
                    visited[i][0] = 1;
                }
            }
        }

        if (color == -1 || color == 1) {
            for (int i = 0; i < n; i++) {
                if (blue_adj[node][i] == 1 && visited[i][1] == 0) {
                    result[i] = (result[i] > dist + 1) ? dist + 1 : result[i];
                    queue[tail++] = i;
                    queue[tail++] = 0;
                    queue[tail++] = dist + 1;
                    visited[i][1] = 1;
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (result[i] == INF) {
            result[i] = -1;
        }
    }

    *returnSize = n;
    return result;
}