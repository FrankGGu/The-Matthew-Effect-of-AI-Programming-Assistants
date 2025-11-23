#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int reachableNodes(int n, int** edges, int edgesSize, int* edgesColSize, int* restricted, int restrictedSize) {
    int *visited = (int*)calloc(n, sizeof(int));
    int *restrict_map = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < restrictedSize; i++) {
        restrict_map[restricted[i]] = 1;
    }

    int count = 0;
    int *queue = (int*)malloc(n * sizeof(int));
    int head = 0, tail = 0;

    if (restrict_map[0] == 0) {
        queue[tail++] = 0;
        visited[0] = 1;
        count++;
    } else {
        free(visited);
        free(restrict_map);
        free(queue);
        return 0;
    }

    while (head < tail) {
        int u = queue[head++];
        for (int i = 0; i < edgesSize; i++) {
            int v = -1;
            if (edges[i][0] == u && visited[edges[i][1]] == 0 && restrict_map[edges[i][1]] == 0) {
                v = edges[i][1];
            } else if (edges[i][1] == u && visited[edges[i][0]] == 0 && restrict_map[edges[i][0]] == 0) {
                v = edges[i][0];
            }

            if (v != -1) {
                queue[tail++] = v;
                visited[v] = 1;
                count++;
            }
        }
    }

    free(visited);
    free(restrict_map);
    free(queue);
    return count;
}