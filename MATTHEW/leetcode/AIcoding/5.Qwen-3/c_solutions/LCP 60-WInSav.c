#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

int compare(const void *a, const void *b) {
    Point *p1 = (Point *)a;
    Point *p2 = (Point *)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

int** findQueue(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** result = (int**)malloc(rows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < rows; i++) {
        int count = 0;
        Point* points = (Point*)malloc(rows * cols * sizeof(Point));
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                points[count].x = i;
                points[count].y = j;
                count++;
            }
        }
        if (count > 0) {
            qsort(points, count, sizeof(Point), compare);
            result[*returnSize] = (int*)malloc(count * 2 * sizeof(int));
            for (int k = 0; k < count; k++) {
                result[*returnSize][2 * k] = points[k].x;
                result[*returnSize][2 * k + 1] = points[k].y;
            }
            (*returnColumnSizes)[*returnSize] = count * 2;
            (*returnSize)++;
            free(points);
        }
    }

    return result;
}