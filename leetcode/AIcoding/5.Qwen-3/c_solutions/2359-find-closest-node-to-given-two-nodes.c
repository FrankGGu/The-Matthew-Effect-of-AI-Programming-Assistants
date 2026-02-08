#include <stdio.h>
#include <stdlib.h>

int* closestNode(int n, int** edges, int edgesSize, int* edgesColSize, int x, int y, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int* distX = (int*)malloc(n * sizeof(int));
    int* distY = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        distX[i] = -1;
        distY[i] = -1;
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    distX[x] = 0;
    queue[rear++] = x;

    while (front < rear) {
        int node = queue[front++];
        for (int i = 0; i < edgesSize; i++) {
            if (edges[i][0] == node && distX[edges[i][1]] == -1) {
                distX[edges[i][1]] = distX[node] + 1;
                queue[rear++] = edges[i][1];
            }
            if (edges[i][1] == node && distX[edges[i][0]] == -1) {
                distX[edges[i][0]] = distX[node] + 1;
                queue[rear++] = edges[i][0];
            }
        }
    }

    front = 0, rear = 0;
    distY[y] = 0;
    queue[rear++] = y;

    while (front < rear) {
        int node = queue[front++];
        for (int i = 0; i < edgesSize; i++) {
            if (edges[i][0] == node && distY[edges[i][1]] == -1) {
                distY[edges[i][1]] = distY[node] + 1;
                queue[rear++] = edges[i][1];
            }
            if (edges[i][1] == node && distY[edges[i][0]] == -1) {
                distY[edges[i][0]] = distY[node] + 1;
                queue[rear++] = edges[i][0];
            }
        }
    }

    int minDist = INT_MAX;
    int index = 0;

    for (int i = 0; i < n; i++) {
        int currentDist = fmin(distX[i], distY[i]);
        if (currentDist < minDist) {
            minDist = currentDist;
            index = i;
        }
    }

    result[0] = index;
    *returnSize = 1;

    free(queue);
    free(distX);
    free(distY);

    return result;
}