#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int value;
    int row;
    int col;
} Element;

int compare(const void *a, const void *b) {
    return ((Element *)a)->value - ((Element *)b)->value;
}

int kthSmallest(int** mat, int matSize, int* matColSize, int k) {
    int n = matSize, m = matColSize[0];
    int *sums = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) sums[i] = mat[i][0];

    Element *heap = (Element *)malloc(k * sizeof(Element));
    for (int i = 0; i < k; ++i) {
        heap[i].value = sums[i];
        heap[i].row = i;
        heap[i].col = 0;
    }

    qsort(heap, k, sizeof(Element), compare);

    int result = 0;

    for (int i = 0; i < k; i++) {
        result = heap[i].value;
        int row = heap[i].row;
        int col = heap[i].col;

        if (col + 1 < m) {
            sums[row] = result - mat[row][col] + mat[row][col + 1];
            heap[i].value = sums[row];
            heap[i].col++;
        }
    }

    free(sums);
    free(heap);

    return result;
}