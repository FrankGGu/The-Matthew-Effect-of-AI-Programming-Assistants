#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool validPath(int n, int** edges, int edgesSize, int* edgesColSize, int source, int destination) {
    if (source == destination) return true;

    bool* visited = (bool*)calloc(n, sizeof(bool));
    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    visited[source] = true;
    queue[rear++] = source;

    while (front < rear) {
        int u = queue[front++];

        for (int i = 0; i < edgesSize; i++) {
            int v = -1;
            if (edges[i][0] == u) {
                v = edges[i][1];
            } else if (edges[i][1] == u) {
                v = edges[i][0];
            }

            if (v != -1 && !visited[v]) {
                if (v == destination) {
                    free(visited);
                    free(queue);
                    return true;
                }
                visited[v] = true;
                queue[rear++] = v;
            }
        }
    }

    free(visited);
    free(queue);
    return false;
}