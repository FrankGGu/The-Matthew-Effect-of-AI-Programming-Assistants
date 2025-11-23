#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shortestCycle(int n, int** edges, int edgesSize, int* edgesColSize) {
    int adj[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            adj[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        adj[edges[i][0]][edges[i][1]] = 1;
        adj[edges[i][1]][edges[i][0]] = 1;
    }

    int minCycle = INT_MAX;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (adj[i][j]) {
                for (int k = 0; k < n; k++) {
                    if (k != i && k != j && adj[i][k] && adj[j][k]) {
                        minCycle = 3;
                        return minCycle;
                    }
                }
            }
        }
    }

    for(int startNode = 0; startNode < n; startNode++){
        int dist[n];
        int parent[n];
        for(int i = 0; i < n; i++){
            dist[i] = INT_MAX;
            parent[i] = -1;
        }

        dist[startNode] = 0;
        int queue[n];
        int front = 0, rear = 0;
        queue[rear++] = startNode;

        while(front < rear){
            int u = queue[front++];

            for(int v = 0; v < n; v++){
                if(adj[u][v] && v != parent[u]){
                    if(dist[v] == INT_MAX){
                        dist[v] = dist[u] + 1;
                        parent[v] = u;
                        queue[rear++] = v;
                    } else {
                        int cycleLen = dist[u] + dist[v] + 1;
                        if(cycleLen < minCycle){
                            minCycle = cycleLen;
                        }
                    }
                }
            }
        }
    }

    if (minCycle == INT_MAX) {
        return -1;
    }

    return minCycle;
}