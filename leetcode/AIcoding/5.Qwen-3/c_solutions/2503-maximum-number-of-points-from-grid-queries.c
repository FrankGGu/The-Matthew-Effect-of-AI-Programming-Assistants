#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int index;
    int value;
} QueryWithIndex;

int compareQueries(const void *a, const void *b) {
    return ((QueryWithIndex *)a)->value - ((QueryWithIndex *)b)->value;
}

int comparePoints(const void *a, const void *b) {
    return ((Point *)a)->x - ((Point *)b)->x;
}

int maxPoints(int** grid, int gridSize, int* gridColSize, int* queries, int queriesSize) {
    int n = gridSize;
    int m = gridColSize[0];

    Point points[n * m];
    int idx = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            points[idx].x = grid[i][j];
            points[idx++].y = i * m + j;
        }
    }

    qsort(points, n * m, sizeof(Point), comparePoints);

    QueryWithIndex queriesWithIndex[queriesSize];
    for (int i = 0; i < queriesSize; i++) {
        queriesWithIndex[i].index = i;
        queriesWithIndex[i].value = queries[i];
    }

    qsort(queriesWithIndex, queriesSize, sizeof(QueryWithIndex), compareQueries);

    int result[queriesSize];
    int visited[n * m];
    memset(visited, 0, sizeof(visited));

    int total = 0;
    int k = 0;

    for (int i = 0; i < queriesSize; i++) {
        int queryValue = queriesWithIndex[i].value;
        int queryIndex = queriesWithIndex[i].index;

        while (k < n * m && points[k].x <= queryValue) {
            int pos = points[k].y;
            int row = pos / m;
            int col = pos % m;

            if (!visited[pos]) {
                visited[pos] = 1;
                total++;

                if (row > 0 && !visited[(row - 1) * m + col]) {
                    visited[(row - 1) * m + col] = 1;
                    total++;
                }
                if (row < n - 1 && !visited[(row + 1) * m + col]) {
                    visited[(row + 1) * m + col] = 1;
                    total++;
                }
                if (col > 0 && !visited[row * m + (col - 1)]) {
                    visited[row * m + (col - 1)] = 1;
                    total++;
                }
                if (col < m - 1 && !visited[row * m + (col + 1)]) {
                    visited[row * m + (col + 1)] = 1;
                    total++;
                }
            }
            k++;
        }

        result[queryIndex] = total;
    }

    for (int i = 0; i < queriesSize; i++) {
        queries[i] = result[i];
    }

    return queriesSize;
}