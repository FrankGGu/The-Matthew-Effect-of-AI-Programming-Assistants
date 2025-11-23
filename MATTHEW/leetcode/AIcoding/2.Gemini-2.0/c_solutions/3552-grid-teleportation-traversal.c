#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int n, int m, int startRow, int startCol, int destRow, int destCol, int* teleportRow, int teleportRowSize, int* teleportCol, int teleportColSize, int teleportCost) {
    int* dist = (int*)malloc(n * m * sizeof(int));
    for (int i = 0; i < n * m; i++) {
        dist[i] = -1;
    }

    int start = startRow * m + startCol;
    dist[start] = 0;

    int* queue = (int*)malloc(n * m * sizeof(int));
    int head = 0, tail = 0;
    queue[tail++] = start;

    while (head < tail) {
        int u = queue[head++];
        int row = u / m;
        int col = u % m;

        int dr[] = {0, 0, 1, -1};
        int dc[] = {1, -1, 0, 0};

        for (int i = 0; i < 4; i++) {
            int newRow = row + dr[i];
            int newCol = col + dc[i];

            if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < m) {
                int v = newRow * m + newCol;
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    queue[tail++] = v;
                }
            }
        }

        for (int i = 0; i < teleportRowSize; i++) {
            int newRow = teleportRow[i];
            int newCol = teleportCol[i];

            int v = newRow * m + newCol;
            if (dist[v] == -1) {
                dist[v] = dist[u] + teleportCost;
                queue[tail++] = v;
            }
        }
    }

    int dest = destRow * m + destCol;
    int result = dist[dest];

    free(dist);
    free(queue);

    return result;
}