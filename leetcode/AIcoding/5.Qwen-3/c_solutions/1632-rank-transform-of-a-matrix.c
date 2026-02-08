#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int index;
} Pair;

int compare(const void *a, const void *b) {
    return ((Pair *)a)->val - ((Pair *)b)->val;
}

int* arrayRankTransform(int* arr, int arrSize, int* returnSize) {
    if (arrSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    Pair *sorted = (Pair *)malloc(arrSize * sizeof(Pair));
    for (int i = 0; i < arrSize; i++) {
        sorted[i].val = arr[i];
        sorted[i].index = i;
    }

    qsort(sorted, arrSize, sizeof(Pair), compare);

    int *rank = (int *)malloc(arrSize * sizeof(int));
    int currentRank = 1;

    for (int i = 0; i < arrSize; i++) {
        if (i > 0 && sorted[i].val != sorted[i - 1].val) {
            currentRank = i + 1;
        }
        rank[sorted[i].index] = currentRank;
    }

    free(sorted);
    *returnSize = arrSize;
    return rank;
}