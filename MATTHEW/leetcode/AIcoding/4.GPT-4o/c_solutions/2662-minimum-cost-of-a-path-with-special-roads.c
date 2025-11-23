#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int x, y, cost;
} Road;

typedef struct {
    int x, y, cost;
} Node;

int minCost(int** roads, int roadsSize, int* roadsColSize, int start, int end) {
    int n = 1001;
    int *dist = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) dist[i] = INT_MAX;
    dist[start] = 0;

    Road* roadList = (Road*)malloc(roadsSize * sizeof(Road));
    for (int i = 0; i < roadsSize; i++) {
        roadList[i] = (Road){roads[i][0], roads[i][1], roads[i][2]};
    }

    for (int i = 0; i < roadsSize; i++) {
        for (int j = 0; j < roadsSize; j++) {
            if (roadList[i].y == roadList[j].x) {
                int newCost = dist[roadList[i].x] + roadList[j].cost;
                if (newCost < dist[roadList[j].y]) {
                    dist[roadList[j].y] = newCost;
                }
            }
        }
    }

    int result = dist[end];
    free(dist);
    free(roadList);
    return result == INT_MAX ? -1 : result;
}