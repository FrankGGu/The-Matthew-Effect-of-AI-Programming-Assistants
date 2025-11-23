#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

int minMovesToSpreadStones(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = *gridColSize;
    int total = 0;
    Point* points = (Point*)malloc(n * m * sizeof(Point));
    int count = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            total += grid[i][j];
            if (grid[i][j] > 1) {
                points[count++] = (Point){i, j};
            }
        }
    }

    int* centers = (int*)malloc((count) * sizeof(int));
    int centerCount = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 1) {
                centers[centerCount++] = i * m + j;
            }
        }
    }

    int result = 0;
    for (int i = 0; i < count; i++) {
        int x = points[i].x;
        int y = points[i].y;
        int dist = abs(x - (centers[i] / m)) + abs(y - (centers[i] % m));
        result += dist;
    }

    free(points);
    free(centers);
    return result;
}