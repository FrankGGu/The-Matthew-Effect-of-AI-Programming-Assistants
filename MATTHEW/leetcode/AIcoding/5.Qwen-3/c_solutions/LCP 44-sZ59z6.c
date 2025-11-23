#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

int** getSkyline(int** buildings, int buildingsSize, int* buildingsColSize, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    if (buildingsSize == 0) return result;

    int n = buildingsSize;
    int** events = (int**)malloc(n * 2 * sizeof(int*));
    for (int i = 0; i < n * 2; i++) {
        events[i] = (int*)malloc(3 * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        int x1 = buildings[i][0];
        int y1 = buildings[i][1];
        int h = buildings[i][2];
        events[2 * i][0] = x1;
        events[2 * i][1] = -h;
        events[2 * i][2] = y1;
        events[2 * i + 1][0] = y1;
        events[2 * i + 1][1] = h;
        events[2 * i + 1][2] = 0;
    }

    qsort(events, n * 2, sizeof(int*), [](const void* a, const void* b) {
        int* A = *(int**)a;
        int* B = *(int**)b;
        if (A[0] != B[0]) return A[0] - B[0];
        if (A[1] != B[1]) return A[1] - B[1];
        return A[2] - B[2];
    });

    int prevHeight = 0;
    int currentHeight = 0;
    int* heap = (int*)malloc(n * sizeof(int));
    int heapSize = 0;

    for (int i = 0; i < n * 2; i++) {
        int x = events[i][0];
        int h = events[i][1];
        int y = events[i][2];

        if (h < 0) {
            heap[heapSize++] = -h;
            int j = heapSize - 1;
            while (j > 0 && heap[(j - 1) / 2] < heap[j]) {
                int temp = heap[(j - 1) / 2];
                heap[(j - 1) / 2] = heap[j];
                heap[j] = temp;
                j = (j - 1) / 2;
            }
        } else {
            for (int j = 0; j < heapSize; j++) {
                if (heap[j] == h) {
                    heap[j] = heap[heapSize - 1];
                    heapSize--;
                    break;
                }
            }
            for (int j = 0; j < heapSize; j++) {
                int k = j;
                while (k > 0 && heap[(k - 1) / 2] < heap[k]) {
                    int temp = heap[(k - 1) / 2];
                    heap[(k - 1) / 2] = heap[k];
                    heap[k] = temp;
                    k = (k - 1) / 2;
                }
            }
        }

        currentHeight = heapSize > 0 ? heap[0] : 0;

        if (currentHeight != prevHeight) {
            *returnSize += 1;
            *returnColumnSizes = (int*)realloc(*returnColumnSizes, *returnSize * sizeof(int));
            (*returnColumnSizes)[*returnSize - 1] = 2;
            result = (int**)realloc(result, *returnSize * sizeof(int*));
            result[*returnSize - 1] = (int*)malloc(2 * sizeof(int));
            result[*returnSize - 1][0] = x;
            result[*returnSize - 1][1] = currentHeight;
            prevHeight = currentHeight;
        }
    }

    free(heap);
    for (int i = 0; i < n * 2; i++) {
        free(events[i]);
    }
    free(events);

    return result;
}