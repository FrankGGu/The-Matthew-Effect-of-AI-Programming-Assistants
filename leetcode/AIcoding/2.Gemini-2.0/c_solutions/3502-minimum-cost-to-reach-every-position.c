#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCostToReachEveryPosition(int* startPos, int startPosSize, int* targetPos, int targetPosSize, int* cost, int costSize) {
    int minX = INT_MAX, maxX = INT_MIN, minY = INT_MAX, maxY = INT_MIN;
    for (int i = 0; i < targetPosSize; i += 2) {
        minX = (targetPos[i] < minX) ? targetPos[i] : minX;
        maxX = (targetPos[i] > maxX) ? targetPos[i] : maxX;
        minY = (targetPos[i + 1] < minY) ? targetPos[i + 1] : minY;
        maxY = (targetPos[i + 1] > maxY) ? targetPos[i + 1] : maxY;
    }
    minX = (startPos[0] < minX) ? startPos[0] : minX;
    maxX = (startPos[0] > maxX) ? startPos[0] : maxX;
    minY = (startPos[1] < minY) ? startPos[1] : minY;
    maxY = (startPos[1] > maxY) ? startPos[1] : maxY;

    int width = maxX - minX + 1;
    int height = maxY - minY + 1;

    int graphSize = width * height;
    int* dist = (int*)malloc(graphSize * sizeof(int));
    for (int i = 0; i < graphSize; i++) {
        dist[i] = INT_MAX;
    }

    int startNode = (startPos[0] - minX) + (startPos[1] - minY) * width;
    dist[startNode] = 0;

    int* visited = (int*)malloc(graphSize * sizeof(int));
    for (int i = 0; i < graphSize; i++) {
        visited[i] = 0;
    }

    for (int count = 0; count < graphSize; count++) {
        int u = -1;
        for (int v = 0; v < graphSize; v++) {
            if (visited[v] == 0 && (u == -1 || dist[v] < dist[u])) {
                u = v;
            }
        }

        if (u == -1 || dist[u] == INT_MAX) {
            break;
        }

        visited[u] = 1;

        int x = u % width + minX;
        int y = u / width + minY;

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx >= minX && nx <= maxX && ny >= minY && ny <= maxY) {
                int v = (nx - minX) + (ny - minY) * width;
                int edgeCost;

                if (i == 0) edgeCost = cost[0];
                else if (i == 1) edgeCost = cost[1];
                else if (i == 2) edgeCost = cost[2];
                else edgeCost = cost[3];

                if (dist[u] != INT_MAX && dist[u] + edgeCost < dist[v]) {
                    dist[v] = dist[u] + edgeCost;
                }
            }
        }
    }

    int totalCost = 0;
    for (int i = 0; i < targetPosSize; i += 2) {
        int targetNode = (targetPos[i] - minX) + (targetPos[i + 1] - minY) * width;
        if (dist[targetNode] == INT_MAX) {
            return -1;
        }
        totalCost += dist[targetNode];
    }

    free(dist);
    free(visited);

    return totalCost;
}