#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** getSkyline(int** buildings, int buildingsSize, int* buildingsColSize, int* returnSize, int** returnColumnSizes) {
    int n = buildingsSize;
    int** result = (int**)malloc(0);
    *returnSize = 0;
    *returnColumnSizes = NULL;

    if (n == 0) return result;

    int** points = (int**)malloc(n * 2 * sizeof(int*));
    for (int i = 0; i < n * 2; i++) {
        points[i] = (int*)malloc(2 * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        points[2 * i][0] = buildings[i][0];
        points[2 * i][1] = -buildings[i][2];
        points[2 * i + 1][0] = buildings[i][1];
        points[2 * i + 1][1] = buildings[i][2];
    }

    qsort(points, n * 2, sizeof(int*), [](const void* a, const void* b) {
        int* x = *(int**)a;
        int* y = *(int**)b;
        if (x[0] != y[0]) return x[0] - y[0];
        return x[1] - y[1];
    });

    int** heap = (int**)malloc((n + 1) * sizeof(int*));
    int heapSize = 0;

    int prevHeight = 0;
    int currHeight = 0;

    for (int i = 0; i < n * 2; i++) {
        int x = points[i][0];
        int h = points[i][1];

        if (h < 0) {
            int* newHeight = (int*)malloc(2 * sizeof(int));
            newHeight[0] = -h;
            newHeight[1] = x;
            heap[heapSize++] = newHeight;

            int j = heapSize - 1;
            while (j > 0) {
                int p = (j - 1) / 2;
                if (heap[p][0] >= heap[j][0]) break;
                int* temp = heap[p];
                heap[p] = heap[j];
                heap[j] = temp;
                j = p;
            }
        } else {
            for (int j = 0; j < heapSize; j++) {
                if (heap[j][1] == x) {
                    heap[j] = heap[--heapSize];
                    j--;
                }
            }

            int j = 0;
            while (j < heapSize) {
                int l = 2 * j + 1;
                int r = 2 * j + 2;
                int max = j;
                if (l < heapSize && heap[l][0] > heap[max][0]) max = l;
                if (r < heapSize && heap[r][0] > heap[max][0]) max = r;
                if (max != j) {
                    int* temp = heap[j];
                    heap[j] = heap[max];
                    heap[max] = temp;
                    j = max;
                } else {
                    break;
                }
            }
        }

        currHeight = heapSize > 0 ? heap[0][0] : 0;

        if (currHeight != prevHeight) {
            int* point = (int*)malloc(2 * sizeof(int));
            point[0] = x;
            point[1] = currHeight;
            result = (int**)realloc(result, (*returnSize + 1) * sizeof(int*));
            result[*returnSize] = point;
            (*returnSize)++;
            *returnColumnSizes = (int*)realloc(*returnColumnSizes, (*returnSize) * sizeof(int));
            (*returnColumnSizes)[*returnSize - 1] = 2;
            prevHeight = currHeight;
        }
    }

    for (int i = 0; i < n * 2; i++) {
        free(points[i]);
    }
    free(points);

    for (int i = 0; i < heapSize; i++) {
        free(heap[i]);
    }
    free(heap);

    return result;
}