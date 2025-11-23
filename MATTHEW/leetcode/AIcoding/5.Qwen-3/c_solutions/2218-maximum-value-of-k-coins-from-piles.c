#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int maxScoreKCoins(int** piles, int pilesSize, int* pilesColSize, int k) {
    int total = 0;
    int** sortedPiles = (int**)malloc(pilesSize * sizeof(int*));
    for (int i = 0; i < pilesSize; i++) {
        sortedPiles[i] = (int*)malloc(pilesColSize[i] * sizeof(int));
        for (int j = 0; j < pilesColSize[i]; j++) {
            sortedPiles[i][j] = piles[i][j];
        }
        qsort(sortedPiles[i], pilesColSize[i], sizeof(int), cmp);
    }

    int* heap = (int*)malloc(k * sizeof(int));
    int heapSize = 0;

    for (int i = 0; i < pilesSize; i++) {
        for (int j = 0; j < pilesColSize[i] && j < k; j++) {
            if (heapSize < k) {
                heap[heapSize++] = sortedPiles[i][j];
            } else {
                if (sortedPiles[i][j] > heap[0]) {
                    heap[0] = sortedPiles[i][j];
                    int idx = 0;
                    while (1) {
                        int left = 2 * idx + 1;
                        int right = 2 * idx + 2;
                        int smallest = idx;
                        if (left < heapSize && heap[left] < heap[smallest]) smallest = left;
                        if (right < heapSize && heap[right] < heap[smallest]) smallest = right;
                        if (smallest == idx) break;
                        int temp = heap[idx];
                        heap[idx] = heap[smallest];
                        heap[smallest] = temp;
                        idx = smallest;
                    }
                }
            }
        }
    }

    for (int i = 0; i < heapSize; i++) {
        total += heap[i];
    }

    for (int i = 0; i < pilesSize; i++) {
        free(sortedPiles[i]);
    }
    free(sortedPiles);
    free(heap);

    return total;
}