/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int x;
    int height;
    int is_start;
} Point;

int compare(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;

    if (p1->x != p2->x) {
        return p1->x - p2->x;
    }

    if (p1->is_start && p2->is_start) {
        return p2->height - p1->height;
    }

    if (!p1->is_start && !p2->is_start) {
        return p1->height - p2->height;
    }

    return p1->is_start ? -1 : 1;
}

int** getSkyline(int** buildings, int buildingsSize, int* buildingsColSize, int* returnSize, int** returnColumnSizes) {
    if (buildingsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    Point* points = (Point*)malloc(2 * buildingsSize * sizeof(Point));
    int pointsCount = 0;

    for (int i = 0; i < buildingsSize; i++) {
        points[pointsCount].x = buildings[i][0];
        points[pointsCount].height = buildings[i][2];
        points[pointsCount].is_start = 1;
        pointsCount++;

        points[pointsCount].x = buildings[i][1];
        points[pointsCount].height = buildings[i][2];
        points[pointsCount].is_start = 0;
        pointsCount++;
    }

    qsort(points, pointsCount, sizeof(Point), compare);

    int* heap = (int*)malloc(buildingsSize * sizeof(int));
    int heapSize = 0;

    int* heapCount = (int*)malloc(10001 * sizeof(int));
    for (int i = 0; i < 10001; i++) {
        heapCount[i] = 0;
    }

    int** result = (int**)malloc(2 * buildingsSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(2 * buildingsSize * sizeof(int));
    int resultCount = 0;

    int prevMax = 0;
    heapCount[0] = 1;

    for (int i = 0; i < pointsCount; i++) {
        Point point = points[i];

        if (point.is_start) {
            heapCount[point.height]++;

            int j = heapSize;
            heap[heapSize++] = point.height;

            while (j > 0 && heap[j] > heap[(j - 1) / 2]) {
                int temp = heap[j];
                heap[j] = heap[(j - 1) / 2];
                heap[(j - 1) / 2] = temp;
                j = (j - 1) / 2;
            }
        } else {
            heapCount[point.height]--;
        }

        while (heapSize > 0 && heapCount[heap[0]] == 0) {
            heap[0] = heap[--heapSize];

            int j = 0;
            while (2 * j + 1 < heapSize) {
                int left = 2 * j + 1;
                int right = 2 * j + 2;
                int largest = j;

                if (left < heapSize && heap[left] > heap[largest]) {
                    largest = left;
                }
                if (right < heapSize && heap[right] > heap[largest]) {
                    largest = right;
                }

                if (largest == j) break;

                int temp = heap[j];
                heap[j] = heap[largest];
                heap[largest] = temp;
                j = largest;
            }
        }

        int currentMax = (heapSize > 0) ? heap[0] : 0;

        if (currentMax != prevMax) {
            result[resultCount] = (int*)malloc(2 * sizeof(int));
            result[resultCount][0] = point.x;
            result[resultCount][1] = currentMax;
            (*returnColumnSizes)[resultCount] = 2;
            resultCount++;
            prevMax = currentMax;
        }
    }

    free(points);
    free(heap);
    free(heapCount);

    *returnSize = resultCount;
    return result;
}