#include <stdlib.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int maxDistance(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int** dist = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = (grid[i][j] == 1) ? 0 : 1000000;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) continue;
            if (i > 0) dist[i][j] = MIN(dist[i][j], dist[i-1][j] + 1);
            if (j > 0) dist[i][j] = MIN(dist[i][j], dist[i][j-1] + 1);
        }
    }

    for (int i = n-1; i >= 0; i--) {
        for (int j = n-1; j >= 0; j--) {
            if (grid[i][j] == 1) continue;
            if (i < n-1) dist[i][j] = MIN(dist[i][j], dist[i+1][j] + 1);
            if (j < n-1) dist[i][j] = MIN(dist[i][j], dist[i][j+1] + 1);
        }
    }

    int maxDist = -1;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) {
                maxDist = MAX(maxDist, dist[i][j]);
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(dist[i]);
    }
    free(dist);

    return (maxDist == 1000000 || maxDist == -1) ? -1 : maxDist;
}