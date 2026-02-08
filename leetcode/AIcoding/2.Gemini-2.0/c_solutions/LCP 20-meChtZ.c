#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int* start, int startSize, int* target, int targetSize, int* specialRoads, int specialRoadsSize, int specialRoadsColSize) {
    int n = targetSize;
    int dist[n];
    for (int i = 0; i < n; i++) {
        dist[i] = abs(target[i] - start[0]) + abs(target[i] - start[1]);
    }

    int visited[n];
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    for (int count = 0; count < n; count++) {
        int u = -1;
        for (int i = 0; i < n; i++) {
            if (!visited[i] && (u == -1 || dist[i] < dist[u])) {
                u = i;
            }
        }

        visited[u] = 1;

        for (int i = 0; i < specialRoadsSize / specialRoadsColSize; i++) {
            int x1 = specialRoads[i * specialRoadsColSize];
            int y1 = specialRoads[i * specialRoadsColSize + 1];
            int x2 = specialRoads[i * specialRoadsColSize + 2];
            int y2 = specialRoads[i * specialRoadsColSize + 3];
            int cost = specialRoads[i * specialRoadsColSize + 4];

            int v = -1;
            for(int j = 0; j < n; j++) {
                if(target[j] == x2) {
                    v = j;
                    break;
                }
            }
            if(v == -1) continue;

            if (target[u] == x1) {
                if (dist[u] + cost < dist[v]) {
                    dist[v] = dist[u] + cost;
                }
            }
        }
        for(int i = 0; i < n; i++){
            if(i == u) continue;
            int cost = abs(target[i] - target[u]);
            if(dist[u] + cost < dist[i])
                dist[i] = dist[u] + cost;
        }
    }
    int min_dist = INT_MAX;
    for(int i = 0; i < n; i++){
        if(dist[i] < min_dist)
            min_dist = dist[i];
    }
    return min_dist;
}