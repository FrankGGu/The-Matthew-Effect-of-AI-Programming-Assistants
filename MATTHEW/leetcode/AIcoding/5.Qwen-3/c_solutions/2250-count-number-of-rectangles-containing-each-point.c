#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int* ys;
    int size;
} YList;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int** countRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize, int** points, int pointsSize, int* pointsColSize, int* returnSize, int** returnColumnSizes) {
    YList yLists[101];
    for (int i = 0; i <= 100; i++) {
        yLists[i].ys = NULL;
        yLists[i].size = 0;
    }

    for (int i = 0; i < rectanglesSize; i++) {
        int x = rectangles[i][0];
        int y = rectangles[i][1];
        yLists[x].size++;
        yLists[x].ys = realloc(yLists[x].ys, yLists[x].size * sizeof(int));
        yLists[x].ys[yLists[x].size - 1] = y;
    }

    for (int i = 0; i <= 100; i++) {
        qsort(yLists[i].ys, yLists[i].size, sizeof(int), compare);
    }

    int** result = (int**)malloc(pointsSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(pointsSize * sizeof(int));
    *returnSize = pointsSize;

    for (int i = 0; i < pointsSize; i++) {
        int px = points[i][0];
        int py = points[i][1];
        int count = 0;
        for (int x = px; x <= 100; x++) {
            if (yLists[x].size == 0) continue;
            int* ys = yLists[x].ys;
            int left = 0, right = yLists[x].size - 1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (ys[mid] >= py) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            count += yLists[x].size - left;
        }
        result[i] = (int*)malloc(sizeof(int));
        result[i][0] = count;
        (*returnColumnSizes)[i] = 1;
    }

    return result;
}