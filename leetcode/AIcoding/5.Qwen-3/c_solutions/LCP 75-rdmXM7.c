#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** getSkyline(int** buildings, int buildingsSize, int* buildingsColSize, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    if (buildingsSize == 0) {
        return result;
    }

    int n = buildingsSize;
    int** points = (int**)malloc(n * 2 * sizeof(int*));
    for (int i = 0; i < n * 2; i++) {
        points[i] = (int*)malloc(3 * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        points[2 * i][0] = buildings[i][0];
        points[2 * i][1] = -buildings[i][2];
        points[2 * i][2] = 0;

        points[2 * i + 1][0] = buildings[i][1];
        points[2 * i + 1][1] = buildings[i][2];
        points[2 * i + 1][2] = 1;
    }

    qsort(points, n * 2, sizeof(int*), [](const void* a, const void* b) {
        int* pa = *(int**)a;
        int* pb = *(int**)b;
        if (pa[0] != pb[0]) {
            return pa[0] - pb[0];
        }
        return pa[1] - pb[1];
    });

    int prevHeight = 0;
    int currHeight = 0;
    int* heap = (int*)malloc(n * sizeof(int));
    int heapSize = 0;

    for (int i = 0; i < n * 2; i++) {
        int x = points[i][0];
        int h = points[i][1];
        int type = points[i][2];

        if (type == 0) {
            heap[heapSize++] = h;
            for (int j = heapSize - 1; j > 0 && heap[j] > heap[(j - 1) / 2]; j = (j - 1) / 2) {
                int temp = heap[j];
                heap[j] = heap[(j - 1) / 2];
                heap[(j - 1) / 2] = temp;
            }
        } else {
            for (int j = 0; j < heapSize; j++) {
                if (heap[j] == h) {
                    heap[j] = heap[heapSize - 1];
                    heapSize--;
                    break;
                }
            }
            for (int j = heapSize - 1; j >= 0; j = (j - 1) / 2) {
                int k = j;
                if (k * 2 + 1 < heapSize && heap[k] < heap[k * 2 + 1]) {
                    k = k * 2 + 1;
                }
                if (k * 2 + 2 < heapSize && heap[k] < heap[k * 2 + 2]) {
                    k = k * 2 + 2;
                }
                if (k != j) {
                    int temp = heap[k];
                    heap[k] = heap[j];
                    heap[j] = temp;
                } else {
                    break;
                }
            }
        }

        currHeight = heapSize > 0 ? heap[0] : 0;

        if (currHeight != prevHeight) {
            *returnSize += 1;
            *returnColumnSizes = (int*)realloc(*returnColumnSizes, *returnSize * sizeof(int));
            (*returnColumnSizes)[*returnSize - 1] = 2;
            result = (int**)realloc(result, *returnSize * sizeof(int*));
            result[*returnSize - 1] = (int*)malloc(2 * sizeof(int));
            result[*returnSize - 1][0] = x;
            result[*returnSize - 1][1] = currHeight;
            prevHeight = currHeight;
        }
    }

    free(heap);
    for (int i = 0; i < n * 2; i++) {
        free(points[i]);
    }
    free(points);

    return result;
}