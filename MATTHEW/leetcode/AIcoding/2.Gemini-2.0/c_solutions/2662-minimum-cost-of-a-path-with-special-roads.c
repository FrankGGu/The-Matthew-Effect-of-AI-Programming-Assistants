#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NODES 1005
#define MAX_SPECIAL_ROADS 205

typedef struct {
    int x, y;
} Point;

typedef struct {
    int u, v, cost;
} Edge;

int minCostConnectPoints(int** points, int pointsSize, int* pointsColSize, int startX, int startY, int endX, int endY, int** specialRoads, int specialRoadsSize, int* specialRoadsColSize) {
    int dist[MAX_NODES];
    int visited[MAX_NODES];
    int numNodes = specialRoadsSize + 2;

    for (int i = 0; i < numNodes; i++) {
        dist[i] = INT_MAX;
        visited[i] = 0;
    }

    dist[0] = abs(startX - endX) + abs(startY - endY);

    for (int i = 0; i < specialRoadsSize; i++) {
        int cost1 = abs(startX - specialRoads[i][0]) + abs(startY - specialRoads[i][1]) + specialRoads[i][4] + abs(specialRoads[i][2] - endX) + abs(specialRoads[i][3] - endY);
        dist[i + 1] = abs(startX - specialRoads[i][0]) + abs(startY - specialRoads[i][1]) + specialRoads[i][4] + abs(specialRoads[i][2] - endX) + abs(specialRoads[i][3] - endY);
        int cost2 = abs(specialRoads[i][2] - endX) + abs(specialRoads[i][3] - endY) + abs(specialRoads[i][0] - startX) + abs(specialRoads[i][1] - startY) + specialRoads[i][4];
    }

    for (int count = 0; count < numNodes; count++) {
        int u = -1;
        for (int i = 0; i < numNodes; i++) {
            if (!visited[i] && (u == -1 || dist[i] < dist[u])) {
                u = i;
            }
        }

        if (u == -1) break;

        visited[u] = 1;

        if (u == 0) {
            for (int v = 1; v < numNodes; v++) {
                int x1 = endX, y1 = endY, x2 = specialRoads[v - 1][0], y2 = specialRoads[v - 1][1], cost = abs(x1 - x2) + abs(y1 - y2);
                if (dist[u] + cost + specialRoads[v-1][4] < dist[v]) {
                    dist[v] = dist[u] + cost + specialRoads[v-1][4];
                }
            }
        } else {
            int x1 = specialRoads[u - 1][2], y1 = specialRoads[u - 1][3];
            for (int v = 0; v < numNodes; v++) {
                if (v == u) continue;
                if (v == 0) {
                    int x2 = endX, y2 = endY, cost = abs(x1 - x2) + abs(y1 - y2);
                    if (dist[u] + cost < dist[v]) {
                        dist[v] = dist[u] + cost;
                    }
                } else {
                    int x2 = specialRoads[v - 1][0], y2 = specialRoads[v - 1][1], cost = abs(x1 - x2) + abs(y1 - y2);
                    if (dist[u] + cost + specialRoads[v-1][4] < dist[v]) {
                        dist[v] = dist[u] + cost + specialRoads[v-1][4];
                    }
                }
            }
        }
    }

    int minCost = dist[0];
    for (int i = 1; i < numNodes; i++) {
        if (dist[i] < minCost) {
            minCost = dist[i];
        }
    }

    return minCost;
}